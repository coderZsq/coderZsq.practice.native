let base = require('../base');
let ObjectId = base.ObjectId;
let Scheme = new base.Schema({
    J1: String
});

module.exports = base.mongoose.model('routers', Scheme);;
