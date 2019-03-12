var express = require('express');

var bodyParser = require('body-parser');

var urlencodedParser = bodyParser.urlencoded({
    extended: true
});

var jsonParser = bodyParser.json();

var webServer = express();

webServer.use('/live', urlencodedParser);
// webServer.use('/live', jsonParser);

webServer.post('/live', function(req, res) {
    console.log(req.body);
    res.send(req.body);
});

webServer.listen(8080);