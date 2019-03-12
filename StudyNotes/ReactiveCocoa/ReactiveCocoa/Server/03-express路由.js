var express = require('express');
var server = express();

server.get('/home', function(req, res, next) {
    console.log('1');
    next();
}, function(req, res) {
    console.log('2');
    res.send('请求home');
});

server.listen(8080);