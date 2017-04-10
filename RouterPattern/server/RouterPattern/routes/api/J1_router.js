var router = require('koa-router')();
var J1 = require('../../app/controllers/J1');

router.get('/getJ1List', J1.getJ1List);

module.exports = router;
