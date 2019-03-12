var http = require ('http');

var server = http.createServer(function(req, res) {
    console.log('请求服务器');
    //res.write('hello');
    res.end("hello");
});

server.listen(3000, '172.16.23.170');
console.log('监听3000端口');