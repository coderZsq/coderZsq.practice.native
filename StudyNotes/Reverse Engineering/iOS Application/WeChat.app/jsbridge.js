(function(global) {
  if (global.WeixinJSBridge) return;

  // devtools 跳过
  if (global.navigator && global.navigator.userAgent) {
    var userAgent = global.navigator.userAgent
    if (userAgent.indexOf('appservice') > -1 || userAgent.indexOf('wechatdevtools') > -1) {
      return 
    }
  }

  var isWebView = global.hasOwnProperty('document');
  var isIosWebView = false;

  var invokeCallbacks = {};
  var invokeCallbackId = 0;

  var onCallbacks = {};

  var customEventPrefix = 'custom_event_';
  var subscribeCallbacks = {};

  if (isWebView) {
    var userAgent = global.navigator.userAgent;
    var isAndroidWebView = userAgent.indexOf('Android') != -1;
    isIosWebView = !isAndroidWebView;
  }

  var _invokeHandler = function(event, paramsString, callbackId) {
    if (isIosWebView) {
      global.webkit.messageHandlers.invokeHandler.postMessage({
        event: event,
        paramsString: paramsString,
        callbackId: callbackId,
      });
    } else {
      var result = WeixinJSCore.invokeHandler(event, paramsString, callbackId);
      if (typeof result !== 'undefined' && typeof invokeCallbacks[callbackId] === 'function' && result !== '') {
        try {
          result = JSON.parse(result)
        } catch (e) {
          result = {}
        }
        invokeCallbacks[callbackId](result)
        delete invokeCallbacks[callbackId]
      }
    }
  }

  var _publishHandler = function(event, paramsString, webviewIds) {
    if (isIosWebView) {
      global.webkit.messageHandlers.publishHandler.postMessage({
        event: event,
        paramsString: paramsString,
        webviewIds: webviewIds
      });
    } else {
      WeixinJSCore.publishHandler(event, paramsString, webviewIds);
    }
  }

  var invoke = function(event, params, callback) {
    var paramsString = JSON.stringify(params || {});
    var callbackId = ++invokeCallbackId
    invokeCallbacks[callbackId] = callback;
    _invokeHandler(event, paramsString, callbackId);
  }

  var invokeCallbackHandler = function(callbackId, result) {
    var callback = invokeCallbacks[callbackId];
    if (typeof callback == 'function') {
      callback(result);
    }
    delete invokeCallbacks[callbackId];
  }

  var on = function(event, callback) {
    onCallbacks[event] = callback;
  }

  var publish = function(event, params, webviewIds) {
    webviewIds = webviewIds || [];
    webviewIds = JSON.stringify(webviewIds);

    var customEvent = customEventPrefix + event;
    var paramsString = JSON.stringify(params);
    _publishHandler(customEvent, paramsString, webviewIds);
  }

  var subscribe = function(event, callback) {
    subscribeCallbacks[customEventPrefix + event] = callback;
  }

  var subscribeHandler = function(event, result, webviewId, ext) {
    var callback;
    if (event.indexOf(customEventPrefix) != -1) {
      callback = subscribeCallbacks[event];
    } else {
      callback = onCallbacks[event];
    }
    if (typeof callback == 'function') {
      callback(result, webviewId,ext);
    }
  }

  global.WeixinJSBridge = {
    invoke: invoke,
    invokeCallbackHandler: invokeCallbackHandler,

    on: on,

    publish: publish,

    subscribe: subscribe,
    subscribeHandler: subscribeHandler,
  }

}) (this);
