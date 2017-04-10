exports.getJ1List = async(ctx, next) => {

    ctx.body = {
        models: [{
            text: '我的账户',
            detailText: "欢迎进入=>我的账户",
        }, {
            text: '我的优惠券',
            detailText: "欢迎进入=>我的优惠券",
        }, {
            text: '收货地址',
            detailText: "欢迎进入=>收货地址",
        }, {
            text: '在线客服',
            detailText: "欢迎进入=>在线客服",
        }, {
            text: '用药提醒',
            detailText: "欢迎进入=>用药提醒",
        }, {
            text: '药查查',
            detailText: "欢迎进入=>药查查",
        }, {
            text: '疾病百科',
            detailText: "欢迎进入=>疾病百科",
        }, {
            text: '药品百科',
            detailText: "欢迎进入=>药品百科",
        }, {
            text: '健一咨询',
            detailText: "欢迎进入=>健一咨询",
        }, {
            text: '帮助中心',
            detailText: "欢迎进入=>帮助中心",
        }, {
            text: '点赞/吐槽',
            detailText: "欢迎进入=>点赞/吐槽",
        }, {
            text: '关于健一',
            detailText: "欢迎进入=>关于健一",
        }]
    }
}
