
/**
 * 反HTTP/DNS劫持模块
 * 白名单域名，需要注意内联css中的字体链接，如果是第三方url，请把域名加到劫持白名单中
 * @author: kenkozheng
 */
(function (win) {

    var blackReg;

    win.HijackReport = {
        init: function (config) {
            if (config.blackReg) {
                blackReg = config.blackReg;
            }
        },

        watch: function () {
            win.addEventListener('DOMNodeInserted', checkDivHijack);
            checkIframeHijack();
            document.addEventListener("DOMContentLoaded", function () {
                checkDivHijack();
            }, false);
        }
    };

    function getURLParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = location.search.substr(1).match(reg);
        if (r != null) return decodeURIComponent(r[2]);
        return null;
    }

    function checkIframeHijack() {
        var flag = 'iframe_hijack_redirected';
        if (!getURLParam(flag)) {
            if (self != top) {
                var url = location.href;
                var parts = url.split('#');
                if (location.search) {
                    parts[0] += '&' + flag + '=1';
                } else {
                    parts[0] += '?' + flag + '=1';
                }
                try {;
                    top.location = parts.join('#');
                } catch (e) {
                }
            }
        }
    }

    function checkDivHijack(e) {
        var dom = e ? e.srcElement : document.documentElement;
        if (!dom.outerHTML) {
            return;     //e不是一个dom，只是插入一段文本
        }

        var urlReg = /(https?:)?\/\/[a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6}(:[0-9]{1,6})?\/?[^'")\s]*/gi;
        var domainReg = /^(https?:)?\/\/([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})/i;
        var badURLList = [];
        var nodeList = [dom];
        var collection = dom.getElementsByTagName('*');     //获取到的是collection类型，没有array好用
        for (var i = 0; i < collection.length; i++) {
            nodeList.push(collection[i]);
        }
        for (var i = 0; i < nodeList.length; i++) {
            var node = nodeList[i];
            var urlList = null;
            if(node.nodeName.toUpperCase() == 'IMG' && node.src && domainReg.test(node.src)){
                urlList = [node.src];
            } else if (node.nodeName.toUpperCase() == 'LINK'){
                var href = node.getAttribute('href');
                if(href && domainReg.test(href)){
                    urlList = [href];
                }
            } else if (node.nodeName.toUpperCase() == 'STYLE'){
                urlList = node.innerHTML.match(urlReg);
            } else if ((node.nodeName.toUpperCase() == 'IFRAME' || node.nodeName.toUpperCase() == 'FRAME') && node.src && domainReg.test(node.src)){
                urlList = [node.src];
            } else if (node.getAttribute('style')){
                urlList = node.getAttribute('style').match(urlReg);
            }

            if(urlList){
                var hijack = false;
                for (var k = 0; k < urlList.length; k++) {
                    var domain = domainReg.exec(urlList[k]);
                    if(!domain || !domain[2] || blackReg.test(domain[2])){
                        badURLList.push(urlList[k]);
                        hijack = true;
                    }
                }
                if(hijack){
                    node.setAttribute('style','display:none;position:fixed;top:10000px;');
                    console.log("find hijack: "+badURLList);
                }
            }
        }

        if (badURLList.length) {
            if (e) {
                dom.setAttribute('style','display:none;position:fixed;top:-10000px;')
                console.log("find hijack: "+badURLList);
            }
        }
    }

})(window);

HijackReport.init({
    blackReg: /__xxxx_reg_yyyy__/ //新的正则表达式，一般情况不需要设置这个字段
});
HijackReport.watch();
