// 这个脚本会注入到主frame和iframe中
try {
    if (typeof window.weixinPostMessageHandlers === 'undefined') {
        window.weixinPostMessageHandlers = window.webkit.messageHandlers;
        Object.defineProperty(window, 'weixinPostMessageHandlers', { value: window.weixinPostMessageHandlers,writable:false });
    }

    // hook navigator.geolocation.getCurrentPosition, 增加监控
    var oriGetCurrLocation = navigator.geolocation.getCurrentPosition;
    Object.defineProperty(navigator.geolocation, 'getCurrentPosition',
        { value: function(successCallback,errorCallback,opt)
              {
                  var option = (typeof opt !== 'undefined') ? opt : {};
                  // alert(JSON.stringify(option));
                  oriGetCurrLocation.call(this,
                      function(position) {
                        if (typeof successCallback !== 'undefined') {
                          // alert(position.coords.longitude);
                          window.weixinPostMessageHandlers.monitorHandler.postMessage(JSON.stringify({event: 'getCurrentLocation', errCode: 0, option: option, funcType:1}));
                          successCallback(position);
                        };
                      },
                      function(err) {
                        // alert(err.code + ' ' + err.message);
                        window.weixinPostMessageHandlers.monitorHandler.postMessage(JSON.stringify({event: 'getCurrentLocation', errCode: err.code, option: option, funcType: 1}));
                        if (typeof errorCallback !== 'undefined') {
                          errorCallback(err);
                        };

                      },
                      option
                  );
              },
          writable:true, //用户反馈angular build会修改这个属性，如果false会js运行错误
          configurable: false
        });

    // hook navigator.geolocation.watchPosition，增加监控
    var oriWatchPosition = navigator.geolocation.watchPosition;
    Object.defineProperty(navigator.geolocation, 'watchPosition',
        { value: function(successCallback,errorCallback,opt)
              {
                  var option = (typeof opt !== 'undefined') ? opt : {};
                  var bHaveReport = false;
                  // alert(JSON.stringify(option));
                  oriWatchPosition.call(this,
                      function(position) {
                        if (typeof successCallback !== 'undefined') {
                          // alert(position.coords.longitude);
                          if (!bHaveReport) {
                            bHaveReport = true;
                            window.weixinPostMessageHandlers.monitorHandler.postMessage(JSON.stringify({event: 'getCurrentLocation', errCode: 0, option: option, funcType: 2}));
                          };
                          successCallback(position);
                        };
                      },
                      function(err) {
                        // alert(err.code + ' ' + err.message);
                        window.weixinPostMessageHandlers.monitorHandler.postMessage(JSON.stringify({event: 'getCurrentLocation', errCode: err.code, option: option, funcType: 2}));
                        if (typeof errorCallback !== 'undefined') {
                          errorCallback(err);
                        };

                      },
                      option
                  );
              },
          writable:true,
          configurable: false
        });
} catch (e) {}
