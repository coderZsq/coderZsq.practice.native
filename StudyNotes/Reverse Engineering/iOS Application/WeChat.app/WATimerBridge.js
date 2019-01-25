(function(global) {
  var timerCallbacks = {};
  var timerCallbackId = 0;
  var _weixinJSCore = global.WeixinJSCore
 
  var setTimeout = function(callback, tm)
  {
    var callbackId = ++timerCallbackId
    timerCallbacks[callbackId] = callback;
    return _weixinJSCore.setTimerHandler(callbackId, tm, false);
  }

  var setInterval = function(callback, tm)
  {
    if(isCallbackRegistered(callback)) return -1;
    var callbackId = ++timerCallbackId
    timerCallbacks[callbackId] = callback;
    return _weixinJSCore.setTimerHandler(callbackId, tm, true);
  }
 
 var isCallbackRegistered = function(callback)
 {
    for(var key in timerCallbacks)
    {
        var cb = timerCallbacks[key];
        if (callback == cb) {
            return true;
        }
    }
    return false;
 }

  var _onNativeTimer = function(callbackId, remove)
  {
    var callback = timerCallbacks[callbackId];
    if (typeof callback == 'function') {
      callback();
    }
    if(remove==1)
    {
      delete timerCallbacks[callbackId];
    }
  }

  var clearTimer = function(callbackId)
  {
    _weixinJSCore.clearTimerHandler(callbackId);
    delete timerCallbacks[callbackId];
  }

  global.setTimeout = setTimeout;
  global.setInterval = setInterval;
  global.clearTimeout = clearTimer;
  global.clearInterval = clearTimer;

  global.WeixinTimerBridge = {
    onNativeTimer: _onNativeTimer,
  }
}) (this);
