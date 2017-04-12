var router = require('koa-router')();
var J1 = require('../../app/controllers/J1');

router.get('/getRouters', J1.getRouters);
router.get('/updateRouters/:controller/:client', J1.updateRouters);
router.get('/getJ1List', J1.getJ1List);

module.exports = router;
