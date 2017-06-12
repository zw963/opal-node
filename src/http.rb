require 'nodejs'

http = node_require('http')
port = 1337

http.JS.createServer(lambda {|req, res|
    res.JS.writeHead(200, { 'Content-Type': 'text/plain' }.to_n)
    res.JS.end("Hello World\n")
  }).JS.listen(port)
