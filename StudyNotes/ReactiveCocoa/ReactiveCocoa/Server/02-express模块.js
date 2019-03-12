var express = require('express');

var server = express();

server.get('/', function(req, res) {
    console.log('收到一个get请求');
    res.send('get');
});

server.post('/', function (req, res) {
    console.log('收到一个post请求');
    res.send('post');
});

server.listen(8080);
console.log('监听8080端口');