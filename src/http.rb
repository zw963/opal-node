require 'nodejs'

http = node_require('http')
port = 1337

# `
# http.createServer(function(req, res) {
#   res.writeHead(200, { 'Content-Type': 'text/plain' });
#   res.end('Hello World\n');
# }).listen(port);
# `

# 这是上面 js 代码的等价代码
# http.JS.createServer(->(_req, res) {
#     res.JS.writeHead(200, {'Content-Type': 'text/plain'}.to_n)
#     res.JS.end("Hello World\n")
#   }).JS.listen(port)


# 上面的调用, 使用了四次 .JS 语法, 这看起来不太舒服, 因此使用 method_missing

# http_wrapper = Native(http)

# http_wrapper.createServer(->(_req, res) {
#     opal_res = Native(res)
#     opal_res.writeHead(200, {'Content-Type': 'text/plain'})
#     opal_res.end("Hello World\n")
#   }).listen(port)

# 但是以上方式仍然不够好, 因为我们仍旧需要调用 wrap Native 两次, 而且也不是纯 Ruby 代码.
# 我们期望的是下面这种更 Ruby 的解决方案. (这个 commit 并不工作.)

module HTTP
  class Server
    def self.listen(port, &block)
      # 首先我们需要一个 native 的 http_wrapper 变量.
      http = Native(node_require('http'))
      # 变量之上调用方法, 并传入 block 作为参数, 应该工作?

      # 好吧, 这里失败的原因是:
      # callback 传入了一个 res 对象, 但是这是一个 native 对象.
      # 在传入的 block 之中, 直接在 native 对象之上调用 writeHead 方法, 是不存在的.
      http.createServer(&block).listen(port)
    end
  end
end

HTTP::Server.listen(port) do |_req, res|
  res.JS.writeHead(200, {'Content-Type': 'text/plain'}.to_n)
  res.JS.end "Hello World\n"
end
