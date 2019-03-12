var express = require('express');

var server = express();

var rooms = [];

server.get('/roomlist', function(req, res) {
    resizeTo.send(rooms);
});

server.get('/createroom', function(req, res) {
    // console.log(req.query);
    var room = req.query;
    var isRepeat = false;
    for (var i = 0; i < rooms.length; i++) {
        var r = rooms[i];
        if (r.roomName === room.roomName) {
            isRepeat = true;
            res.send({
                'result': isRepeat
            });
            return;
        }
    }
    if (isRepeat === false) {
        rooms.push(room);
    }
    res.send({'result': isRepeat});
});

server.get('/closeroom', function(req, res) {
    var room = req.query;
    var count = rooms.length;
    var index = 0;
    for (var i = 0; i < count; i++) {
        var r = rooms[i];
        if (r.roomName === room.roomName) {
            index = i;
            break;
        }
    }
    rooms.splice(index, 1);
    console.log(rooms);
    res.send(rooms);
});

server.listen(8080);