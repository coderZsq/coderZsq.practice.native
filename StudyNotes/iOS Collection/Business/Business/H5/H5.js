window.onload = function() {
    var allImg = document.getElementsByTagName('img');
    for (var i = 0; i < allImg.length; i++) {
        var img = allImg[i];
        img.id = i;
        img.onclick = function() {
//            alert('点击了第' + this.id + '张图片!!');xxe
            this.style.width = '100%';
            window.location.href = 'business://openCamera';
        }
    }
};

function setupWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'https://__bridge_loaded__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}

setupWebViewJavascriptBridge(function(bridge) {
    bridge.registerHandler('JS Echo', function(data, responseCallback) {
        console.log("JS Echo called with:", data)
        responseCallback(data)
    })
    bridge.callHandler('ObjC Echo', {'key':'value'}, function responseCallback(responseData) {
        console.log("JS received response:", responseData)
    })
})
