let mongodb = require('./config');
let mongoose = mongodb.mongoose;
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;

exports.mongodb = mongodb;
exports.mongoose = mongoose;
exports.Schema = Schema;
exports.ObjectId = ObjectId;
exports.Mixed = Schema.Types.Mixed;
