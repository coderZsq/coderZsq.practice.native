
var screenWidth = 0;
var screenHeight = 0;

var bullets = new Array();

var bulletId = 'res://bullet.png';
var heroId = 'res://hero.png';
var bgId = 'res://plane_background.jpg';

var picUrlList = ['https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2509318502,2102230469&fm=23&gp=0.jpg', 
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3726866819,3631259881&fm=23&gp=0.jpg', 
    'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2785071478,1884752315&fm=23&gp=0.jpg',
    'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3621043367,2987102409&fm=23&gp=0.jpg'];

//游戏背景
var background = 
{
    left:0,
    top:0,
    width:0,
    height:0,
    init: function(x,y,w,h)
    {
        var _this = this;
        _this.left = x;
        _this.top = y;
        _this.width = w;
        _this.height = h;
    },
    update: function()
    {
        var _this = this;
        _this.top += 2;
        if(_this.top >= screenHeight) {
            _this.top = 0;
        }
    },
};

//游戏主角
var hero = 
{
    left:0,
    top:0,
    width:0,
    height:0,
    touched:false,
    init:function(x,y,w,h)
    {
        var _this = this;
        _this.left = x;
        _this.top = y;
        _this.width = w;
        _this.height = h;
    },
    update:function()
    {
        var _this = this;
        var bullet = {
            left : _this.left,
            top : _this.top,
            width : 16,
            height : 30,
        };
        bullets.push(bullet);
    },
    touchBegin:function(x, y)
    {
        var _this = this;
        var delta = 50;
        if (x >= _this.left - delta 
            && y >= _this.top - delta 
            && x <= _this.left + _this.width + delta 
            && y <= _this.top + _this.height + delta) 
        {
            _this.touched = true;
            _this.left = x;
            _this.top = y;
        }
        else
        {
            _this.touched = false;
        }
    },
    touchEnd:function(x, y)
    {
        var _this = this;
        _this.touched = false;
    },
    touchMove:function(x, y)
    {
        var _this = this;
        if(_this.touched)
        {
            _this.left = x;
            _this.top = y;
        }
    },
};

var sTime = 0;
var sCount = 0;
var sTicker = 0;

function pad(num) {
    var len = num.toString().length;
    if(len < 2) {
        num = "0" + num;
    }
    return num;
}

WeixinJSBridge.on('updateLogicData', function(res) {
    logxx("on updateLogicData:" + res.userData);
    var obj = JSON.parse(res.userData);
    sTime = obj.current_time;
    sCount = obj.online_count;
});

WeixinJSBridge.on('canvasInsert', function(res) {
    // WeixinJSBridge.invoke('createImage', {
    //   base64: bulletBase64,
    // }, function (res) {
    //     bulletId = res.imageId;
    //     logxx('createImage '+bulletId);
    // });

    // WeixinJSBridge.invoke('createImage', {
    //   base64: heroBase64,
    // }, function (res) {
    //     heroId = res.imageId;
    //     logxx('createImage '+heroId);
    // });

    // WeixinJSBridge.invoke('createImage', {
    //   base64: bgBase64,
    // }, function (res) {
    //     bgId = res.imageId;
    //     logxx('createImage '+bgId);
    // });

    screenWidth = res.width;
    screenHeight = res.height;

    background.init(screenWidth/2,screenHeight/2,screenWidth,screenHeight);
    hero.init(screenWidth/2, screenHeight-80, 80, 80);

    var cnt = 0;
    var num = 0;
    setInterval(function() {
        //更新并移动游戏背景
        background.update();
        cnt++;
        if(cnt > 5)
        {
            cnt = 0;
            //更新主角逻辑，主要用于生成子弹
            hero.update();
        }

        //绘制背景
        var actions = [
            {
              method: 'drawImage',
              data: [bgId, background.left-background.width/2, background.top-screenHeight/2-background.height/2, background.width, background.height],
            },
            {
              method: 'drawImage',
              data: [bgId, background.left-background.width/2, background.top+screenHeight/2-background.height/2, background.width, background.height],
            },
        ];

        var i=0;

        //更新子弹位置并绘制子弹
        for(key in bullets) {
            var bullet = bullets[key];
            bullet.top -= 20;
            if(bullet.top < 0)
            {
                bullets.splice(i, 1);
                continue;
            }

            i++;

            var drawObj = 
            {
              method: 'drawImage',
              data: [bulletId, bullet.left - bullet.width/2, bullet.top - bullet.height/2, bullet.width, bullet.height]
            };
            actions.push(drawObj);
        }

        //根据主角位置绘制主角
        var onlineUrl = picUrlList[cnt%picUrlList.length];
        var heroObj =
        {
          method: 'drawImage',
          data: [heroId, hero.left - hero.width/2, hero.top - hero.height/2, hero.width, hero.height]
        };
        actions.push(heroObj);

        actions.push({
          method: 'setFillStyle',
          data: ['normal', [255, 255, 255, 255]]
        });

        actions.push({
          method: 'setFontSize',
          data: [13],
        });
        actions.push({
          method: 'fillText',
          data: ["tick:"+(sTicker++)%100, 10, 20]
        });

        var str = '数据未更新';
        if(sTime > 0) {
            var d = new Date(sTime * 1000);
            var datestring = pad(d.getHours()) + ":" + pad(d.getMinutes()) + ":" + pad(d.getSeconds());
            str = "在线:" + sCount + "  上次更新:" + datestring; 
        }

        actions.push({
          method: 'fillText',
          data: [str, 10, screenHeight - 14],
        });

        WeixinJSBridge.invoke('drawCanvas', {
          canvasId: res.canvasId,
          actions: actions,
        }, function (e) {

        });
    }, 50);
});
