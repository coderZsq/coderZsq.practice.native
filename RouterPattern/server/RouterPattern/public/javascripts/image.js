const http = require('http');
const fs = require('fs');

http.createServer((req, res) => {
    
    let path = __dirname + decodeURI(req.url);
    fs.readFile(path, 'binary', (err, file) => {
        if (err) {
            console.log(err);
            return;
        } else {
            res.writeHead(200, {
                'Content-Type': 'image/png'
            });
            res.write(file, 'binary');
            res.end();
            return;
        }
    })
}).listen(3002);
console.log('port = 3002');
