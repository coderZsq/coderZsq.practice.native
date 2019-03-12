var express = require('express');
var server = express();

server.use('/home', function (req, res, next) {
    console.log('1');
    next();
});

server.get('/home', function (req, res) {
    console.log('2');
    res.send('请求home');
});

server.listen(8080);