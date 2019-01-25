const radius = 70;
const innerRadius = radius * 0.9;

var canvasWidth = 0;
var canvasHeight = 0;

var points = new Array();
var timerId = 0;
var ticker = 0;

WeixinJSBridge.on('canvasInsert', function(res) {
    canvasWidth = res.width;
    canvasHeight = res.height;

    timerId = setInterval(function() {
        var actions = [];

        actions.push({
            method: 'translate',
            data: [canvasWidth/2,  canvasHeight/2],
        });

        // 黑框
		actions.push({
			method: 'setFillStyle',
			data: ['normal', [0, 0, 0, 255]],
		});
        actions.push({
            method: 'fillPath',
            data: [{
            	method: 'rect',
            	data: [-radius*1.2, -radius*1.2, radius*2.4, radius*2.4],
            }],
        });

        // 外圆
		actions.push({
			method: 'setFillStyle',
			data: ['normal', [255, 255, 255, 255]],
		});
        actions.push({
        	method: 'fillPath',
            data: [{
	            method: 'arc',
	            data: [0, 0, radius, 0, 2*Math.PI],
	        }],
        });

        // 内圆
		actions.push({
			method: 'setFillStyle',
			data: ['normal', [0, 0, 0, 255]],
		});
        actions.push({
        	method: 'fillPath',
            data: [{
	            method: 'arc',
	            data: [0, 0, radius*0.1, 0, 2*Math.PI],
	        }],
        });

        actions.push({
			method: 'setFillStyle',
			data: ['normal', [51, 51, 51, 255]],
		});
        // 数字
        for (let num = 1; num <= 12; num++) {
            var angle = num * Math.PI/6 + Math.PI;

            var transform1 = {
                method: 'rotate',
                data: [angle],
            };

            var transform2 = {
                method: 'translate',
                data: [0,  radius*0.85],
            };

            var transform3 = {
                method: 'rotate',
                data: [-angle],
            };

            var textNumber = {
                method: 'fillText',
                data: [""+num, -6, 4],
            };

            var transform4 = {
                method: 'rotate',
                data: [angle],
            };

            var transform5 = {
                method: 'translate',
                data: [0, -radius*0.85],
            };

            var transform6 = {
                method: 'rotate',
                data: [-angle],
            };

            actions.push(transform1);
            actions.push(transform2);
            actions.push(transform3);
            actions.push(textNumber);
            actions.push(transform4);
            actions.push(transform5);
            actions.push(transform6);
        }

        const now = new Date();
        let hour = now.getHours();
        let minute = now.getMinutes();
        let second = now.getSeconds();

        actions.push({
			method: 'setFillStyle',
			data: ['normal', [255, 0, 0, 125]],
		});
        actions.push({
            method: 'fillText',
            data: [`当前时间 ${hour}:${minute}`, -canvasWidth/2,  -canvasHeight/2 + 20],
        });

        actions.push({
            method: 'fillText',
            data: ['tick:'+(ticker++)%100, -canvasWidth/2,  -canvasHeight/2 + 40],
        });

        // hour
        hour = hour % 12
        hour = (hour*Math.PI/6) + (minute*Math.PI/(6*60) + (second*Math.PI/(360*60)));
        drawPointer(hour, innerRadius*0.5, 5, [51, 51, 51, 255]);

        // minute
        minute = (minute*Math.PI/30) + (second*Math.PI/(30*60));
        drawPointer(minute, radius*0.7, 3, [51, 51, 51, 255]);

        // second
        second = (second*Math.PI/30);
        drawPointer(second, radius*0.9, 1, [255, 0, 0, 255]);

        function drawPointer(angle, length, width, color) {
            actions.push({
            	method: 'setStrokeStyle',
            	data: ['normal', color],
            });
            actions.push({
            	method: 'setLineWidth',
            	data: [width],
            });
            actions.push({
                method: 'strokePath',
                data: [{
        			method: 'moveTo',
	                data: [0, 0],
			    }, {
	                method: 'lineTo',
	                data: [Math.sin(angle) * length, - Math.cos(angle) * length],
                }],
            });
        }
    
        WeixinJSBridge.invoke('drawCanvas', {
          canvasId: res.canvasId,
          actions: actions,
          reserve: false,
        }, function(res) {

        });
    }, 100);
});