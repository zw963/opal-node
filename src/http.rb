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
http.JS.createServer(->(_req, res) {
    res.JS.writeHead(200, {'Content-Type': 'text/plain'}.to_n)
    res.JS.end("Hello World\n")
  }).JS.listen(port)
