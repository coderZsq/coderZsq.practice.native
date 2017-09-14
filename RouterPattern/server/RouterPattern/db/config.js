const mongoose = require('mongoose');

var db = mongoose.connect('mongodb://localhost/J1');

db.connection.on("error", function(error) {
    console.log("database connect fail：" + error);
});

db.connection.on("open", function() {
    console.log("database connect success");
})

db.connection.on('disconnected', function() {
    console.log('database disconnected');
})

exports.mongoose = mongoose;
