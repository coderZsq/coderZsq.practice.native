var webServer = require('http').createServer();

var socketIO = require('socket.io');

var serverSocket = socketIO(webServer);

var rooms = [];

serverSocket.on('connection',function(clientSocket){
    clientSocket.on('joinroom', function(room) {
        console.log('有人进来了' + room.roomName);
        clientSocket.join(room.roomName);
        var count = rooms.length;
        for (var i = 0; i < count; i++) {
            var r = rooms[i];
            if (r.roomName != room.roomName) {
                rooms.push(room);
            }
        }
    });
    clientSocket.on('leaveroom', function(roomName) {
        clientSocket.leave(roomName);
    });
    clientSocket.on('msg',function(msg){
        console.log('给' + msg.roomName + '发送' + msg.text);
        serverSocket.to(msg.roomName).emit('msg',msg);
    });
});

webServer.listen(8080);
console.log('监听8080端口');