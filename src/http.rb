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

# 第一步: 添加一个 HTTP 模块

module HTTP
  class Server

  end
end

HTTP::Server.listen(port) do |req, res|
  res.writeHead(200, {'Content-Type': 'text/plain'})
  res.end "Hello World\n"
end
