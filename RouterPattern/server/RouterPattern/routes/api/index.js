var router = require('koa-router')();
var J1_router = require('./J1_router');

router.use('/J1', J1_router.routes(), J1_router.allowedMethods())

module.exports = router;
