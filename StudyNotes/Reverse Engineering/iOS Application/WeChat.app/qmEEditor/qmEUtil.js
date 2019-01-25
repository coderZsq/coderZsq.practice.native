/**
 * created by flyhuang 
 */
(function(){

    function isPlainObject(obj) {
        return isObject(obj) && !isWindow(obj) && obj.__proto__ == Object.prototype
    }

    function isArray(value) { return value instanceof Array }

    function extend(target, source, deep) {
        for (key in source)
          if (deep && (isPlainObject(source[key]) || isArray(source[key]))) {
            if (isPlainObject(source[key]) && !isPlainObject(target[key]))
              target[key] = {}
            if (isArray(source[key]) && !isArray(target[key]))
              target[key] = []
            extend(target[key], source[key], deep)
        }
            else if (source[key] !== undefined) target[key] = source[key]
    }

    function iOSversion() {
        if (/iP(hone|od|ad)/.test(navigator.platform)) {
            // supports iOS 2.0 and later: <http://bit.ly/TJjs1V>
            var v = (navigator.appVersion).match(/OS (\d+)_(\d+)_?(\d+)?/);
            return [parseInt(v[1], 10), parseInt(v[2], 10), parseInt(v[3] || 0, 10)];
        }
    }

    var version = iOSversion()[0];

    QMail.Util = {
        extend : function(target) {
            var deep, args = [].slice.call(arguments, 1);
            if (typeof target == 'boolean') {
              deep = target;
              target = args.shift();
            }
            args.forEach(function(arg){ extend(target, arg, deep) });
            return target;
        },
        subclass : function(child, parent) {
            var _parent = (typeof parent == 'function') ? new parent() : parent;
            child.prototype = _parent;
            child.prototype.constructor = child;
            child.__super__ = _parent.__proto__;
        },
        isIosVersion7 : function() {
 
            return version >= 7.0;
        }
    }

})();
