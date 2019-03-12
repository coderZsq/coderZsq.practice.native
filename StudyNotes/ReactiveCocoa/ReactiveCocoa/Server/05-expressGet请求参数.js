var express = require('express');

var webServer = express();

webServer.get('/live', function(req, res) {
    console.log(req.query);
    res.send('直播数据');
});

webServer.listen(8080);