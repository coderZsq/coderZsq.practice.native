/**
 * created by flyhuang 
 * js通知浏览器的入口集合
 */
(function(){

var __callbacks = {};

QMail.NativeNotifier = {
    validateMessages : {
        'setWebViewOffsetFromJS'       : true,
        'adjustContentSizeToFitFromJs' : true,
        'tapAudioFromJs' : true,
        'setWebViewScaleFromJS'    : true,
        'attachmentsChangedFromJs' : true,
        'domContentLoadedFromJs'   : true,
        'domSubtreeModifiedFromJs' : true,
        'longPressImageFromJs'     : true,
        'pasteFromJs'              : true,
        'getWebViewOffsetFromJS'   : true
    },
    notify: function(method, args, timeout) {

        if(this.validateMessages[method]) {
            var argsStr = [];

            for(var key in args) {
                argsStr.push(key + '=' + encodeURIComponent(args[key]));
            }

            var argsStr = method + '?' + argsStr.join('&');
            var self = this;

            timeout = typeof(timeout) === 'number' ? parseInt(timeout,10) : 0;
            //延迟处理
            if(timeout == 0) {
                this._postMessageToNative(argsStr);
            } else {
                window.setTimeout(function() {
                    self._postMessageToNative(argsStr);
                }, timeout || 0);
            }
        } else {
            QMail.Debug.warn('this notify method is not validate: ' + method);
        }
    },
    notifyWithResponse : function(method, args, callback) {

        var randomId = new Date().getTime();

        __callbacks[randomId] = callback;

        args['__callback'] = randomId;

        this.notify(method, args, 0);
    },
    excuteCallback : function(callbackId) {

        var callback = __callbacks[callbackId];

        if(typeof(callback) == 'function') {
            var params = [].slice.apply(arguments);
            callback && callback.apply(window , params.slice(1));
            delete __callbacks[callbackId];
        }
    },
    _postMessageToNative : function(url) {
        url = QMail.config.notifyName + '://' + url;
        var iframe = document.createElement("IFRAME");
        iframe.setAttribute("src", url);
        document.documentElement.appendChild(iframe);
        iframe.parentNode.removeChild(iframe);
        iframe = null;
    }
};

})();

