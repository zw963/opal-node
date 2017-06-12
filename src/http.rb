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

http_wrapper = Native(http)

http_wrapper.createServer(->(_req, res) {
    opal_res = Native(res)
    opal_res.writeHead(200, {'Content-Type': 'text/plain'})
    opal_res.end("Hello World\n")
  }).listen(port)
