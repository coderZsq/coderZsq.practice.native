var tool = require('./utils/tool');
tool.log();
console.log(tool.age);

var User = require('./model/User');
var user = new User('Cas', 26);
console.log(user);

var express = require('express');

var server = express();

server.get('/', function(req, res) {
    res.send(user);
});

server.listen(8080);