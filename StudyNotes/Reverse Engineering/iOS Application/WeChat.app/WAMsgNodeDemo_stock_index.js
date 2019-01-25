const kStep = 2;
const kEdage = 10;

var canvasWidth = 0;
var canvasHeight = 0;

var points = new Array();
var timerId = 0;

WeixinJSBridge.on('canvasInsert', function(res) {
    canvasWidth = res.width;
    canvasHeight = res.height;

    timerId = setInterval(function() {
        if (points.length > canvasWidth/kStep + 1) {
            points.shift();
        }

        if (points.length == 0) {
            var x = canvasWidth - kStep;
            var y = canvasHeight/2;
            points.push({x, y});
        } else {
            for (key in points) {
                var point = points[key];
                points[key].x -= kStep;
            }
        }

        var x = canvasWidth;
        var y = points[points.length - 1].y + Math.random()*20*(Math.random() < 0.5 ? -1 : 1);
        y = Math.min(y, canvasHeight - kEdage);
        y = Math.max(y, kEdage);
        points.push({x, y});

        var paths = new Array();
        paths.push({
            method: 'moveTo',
            data: [points[0].x, points[0].y]
        });
        for (var key in points) {
            var point = points[key];
            paths.push({
                method: 'lineTo',
                data: [point.x, point.y]
            });
        }

        var actions = [];
        actions.push({
            method: 'setStrokeStyle',
            data: ["normal", [255, 0, 0, 255]],
        });
        actions.push({
            method: 'setLineWidth',
            data: [2],
        });
        actions.push({
            method: 'strokePath',
            data: paths,
        });
        
        WeixinJSBridge.invoke('drawCanvas', {
          canvasId: res.canvasId,
          actions: actions
        }, function(res) {

        });
    }, 30);
});