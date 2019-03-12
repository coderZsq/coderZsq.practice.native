var http = require('http');

var server = http.createServer();

var socketIO = require('socket.io');

var serverSocket = socketIO(server);

serverSocket.on('connection', function (clientSocket) {
    console.log('建立连接成功');
    clientSocket.on('chat', function (data) {
        clientSocket.emit('chat', '你吃饭了吗');
        console.log(data);
    });
});

server.listen(8080);
console.log('监听8080');