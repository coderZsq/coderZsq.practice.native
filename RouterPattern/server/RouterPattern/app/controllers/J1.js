exports.getRouters = async(ctx, next) => {

  // var routers = await Routers.find({});
  // ctx.body = {
  //     routers: routers[0]
  // }

  ctx.body = {
    routers: {
      "J1": 'app'
    }
  }
}

exports.updateRouters = async(ctx, next) => {

  const controller = ctx.params.controller;
  const client = ctx.params.client;

  if (controller === 'J1') {
    Routers.update({
      mvvm: client
    }, (err, doc) => {
      console.log(doc);
    })
  } else {
    console.log('controller is not exist');
  }
}

exports.getJ1List = async(ctx, next) => {

  ctx.body = {
    models: [{
      text: '我的账户',
      detailText: "欢迎进入=>我的账户",
      imageUrl: "http://localhost:3002/images/J1/我的账户@2x.png"
    }, {
      text: '我的优惠券',
      detailText: "欢迎进入=>我的优惠券",
      imageUrl: "http://localhost:3002/images/J1/我的优惠券@2x.png"
    }, {
      text: '收货地址',
      detailText: "欢迎进入=>收货地址",
      imageUrl: "http://localhost:3002/images/J1/收货地址@2x.png"
    }, {
      text: '在线客服',
      detailText: "欢迎进入=>在线客服",
      imageUrl: "http://localhost:3002/images/J1/在线客服@2x.png"
    }, {
      text: '用药提醒',
      detailText: "欢迎进入=>用药提醒",
      imageUrl: "http://localhost:3002/images/J1/用药提醒@2x.png"
    }, {
      text: '药查查',
      detailText: "欢迎进入=>药查查",
      imageUrl: "http://localhost:3002/images/J1/药查查@2x.png"
    }, {
      text: '疾病百科',
      detailText: "欢迎进入=>疾病百科",
      imageUrl: "http://localhost:3002/images/J1/疾病百科@2x.png"
    }, {
      text: '药品百科',
      detailText: "欢迎进入=>药品百科",
      imageUrl: "http://localhost:3002/images/J1/药品百科@2x.png"
    }, {
      text: '健一咨询',
      detailText: "欢迎进入=>健一咨询",
      imageUrl: "http://localhost:3002/images/J1/健一咨询@2x.png"
    }, {
      text: '帮助中心',
      detailText: "欢迎进入=>帮助中心",
      imageUrl: "http://localhost:3002/images/J1/帮助中心@2x.png"
    }, {
      text: '点赞/吐槽',
      detailText: "欢迎进入=>点赞/吐槽",
      imageUrl: "http://localhost:3002/images/J1/点赞:吐槽@2x.png"
    }, {
      text: '关于健一',
      detailText: "欢迎进入=>关于健一",
      imageUrl: "http://localhost:3002/images/J1/关于健一@2x.png"
    }]
  }
}
