require 'nodejs'

http = node_require('http')
port = 1337

`
http.createServer(function(req, res) {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World\n');
}).listen(port);
`
