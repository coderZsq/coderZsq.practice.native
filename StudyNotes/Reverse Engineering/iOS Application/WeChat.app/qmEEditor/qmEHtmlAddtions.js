/**
 * created by flyhuang 
 * 一些html的addtions工具函数和类定义
 */
if (typeof String.prototype.trim != 'function') {
    String.prototype.trim = function trim() {
        return this.replace(/^\s+\n+\r+/, "").replace(/\s+\n+\r+$/, "");
    };
}

//判断是否只包含换行符号
String.prototype.isPrintable = function isPrintable() {
    return (this.match(/[^\s\t\n\r]/)) ? true: false;
};

if (typeof Node != 'undefined') {

    Node.prototype.isContentNode = function isContentNode() {
        return this.textContent.isPrintable();
    };
    Node.prototype.isNodeWithContent = function isNodeWithContent() {
        return this.isContentNode();
    };

    Node.prototype.isEmptyNode = function isEmptyNode() {
        return (this.textContent.match(/[^\s\t\n\r]/)) ? true: false;
    };

    Node.prototype.remove = function() {
        if (this.parentNode) {
            this.parentNode.removeChild(this);
        }
    };

    Node.prototype.getParentElementByName = function getParentElementByName(nodeName) {
        var targetNodeName = nodeName.toUpperCase();
        var targetNode = this.parentElement;
        while (targetNode && targetNode.nodeName != targetNodeName) {
            targetNode = targetNode.parentElement;
        }
        return targetNode;
    };

    Node.prototype.removeAllChilds = function() {
       while (this.firstChild) {
            this.removeChild(this.firstChild);
        }
    };

    Node.prototype.isSpecialElement = function isSpecialElement() {
        return false;
    };

    Node.prototype.isBlockFormatNode = function isBlockFormatNode() {
        return false;
    };
}

if (typeof HTMLElement != 'undefined') {

    //参考文章：https://www.webkit.org/blog/1737/apple-style-span-is-gone/
    //参考文章：https://code.google.com/p/chromium/issues/detail?id=28904
    HTMLElement.prototype.APPLE_STYLE_SPAN_CLASSNAME = "Apple-style-span";

    HTMLElement.prototype.isLineBreakingElement = function isLineBreakingElement() {
        var lastChild = this.children[this.children.length - 1];
        if (lastChild && lastChild.nodeName == "BR") {
            return true;
        }
        return false;
    };

    HTMLElement.prototype.isEmptyNode = function isEmptyNode() {
        if (this.isNodeWithContent()) {
            return (!this.textContent.isPrintable() && this.childElementCount == 1 && this.isLineBreakingElement()) ? true: false;
        }
        return true;
    };

    HTMLElement.prototype.removeAppleStyleSpans = function removeAppleStyleSpans(callback) {
        var cb = (typeof callback == 'function') ? callback: null;
        if (this.classList.contains(this.APPLE_STYLE_SPAN_CLASSNAME) && (!cb || cb(this))) {
            this.remove();
            return;
        }
        var children = this.querySelectorAll("." + this.APPLE_STYLE_SPAN_CLASSNAME);
        if (!children || children.length === 0) {
            return;
        }
        children = Array.prototype.slice.call(children, 0);
        for (var i = 0; i < children.length; i++) {
            var child = children[i];
            if (child && (!cb || cb(child))) {
                child.remove();
            }
        }
    };
    HTMLElement.prototype.removeEmptyAppleStyleSpans = function removeEmptyAppleStyleSpans(callback) {
        var cb = (typeof callback == 'function') ? callback: null;
        function _callback(node) {
            if (node.childNodes.length === 0 && (!cb || cb(node))) {
                return true;
            }
            return false;
        }
        this.removeAppleStyleSpans(callback);
    };

    HTMLElement.prototype.QM_TITLE_ATTR_NAME = "qmtitle";
    HTMLElement.prototype.LIST_NODES = {
        "UL": null,
        "OL": null,
        "DL": null
    };

    HTMLElement.prototype.FORMAT_NODES = {
        "B": null,
        "I": null,
        "U": null,
        "STRIKE": null,
        "S": null
    };

    HTMLElement.prototype.getAttachId = function() {
        return this.getAttribute('attachId');
    }

    HTMLElement.prototype.setAttachId = function(id) {
        this.setAttribute('attachId', id);
    }

    HTMLElement.prototype.setAttributes = function(namedNodeMap) {
        for (var i = 0; i < namedNodeMap.length; i++) {
            var attr = namedNodeMap[i];
            if (attr.nodeValue) {
                this.setAttribute(attr.nodeName, attr.nodeValue);
            }
        }
    };
    HTMLElement.prototype.removeAttributes = function(attrNames) {
        var _attrs = [].concat(attrNames);
        for (var i = 0; i < _attrs.length; i++) {
            var a = _attrs[i];
            this.removeAttribute(a);
        }
    };

    HTMLElement.prototype.replace = function(newElement) {
        if (this.parentNode) {
            this.parentNode.replaceChild(newElement, this);
        }
        return newElement;
    };
    
    HTMLElement.prototype.hide = function() {
        this.style["display"] = "none";
    };
    HTMLElement.prototype.show = function() {
        this.style["display"] = "";
    };

    HTMLElement.prototype.setTitle = function(title) {
        this.setAttribute(this.QM_TITLE_ATTR_NAME, title);
    }

    HTMLElement.prototype.getTitle = function() {
        this.getAttribute(this.QM_TITLE_ATTR_NAME);
    }

    HTMLElement.prototype.isCheckboxElement = function isCheckboxElement() {
        return (this.nodeName == "INPUT" && this.type == "checkbox") ? true: false;
    };

    HTMLElement.prototype.hasTapElementWithClass = function(cls) {
        
        var target = this;

        while (target && target != document.body) {
            if (target.hasClass(cls)) {
                return target;
            }
            target = target.parentNode;
        }

        return false;
    }     
    
    HTMLElement.prototype.TAP_TIMEOUT = 300;
    HTMLElement.prototype.LONG_PRESS_TIME = 1000;
    HTMLElement.prototype.TAP_DELAY = 300;
    HTMLElement.prototype.TAP_CALLBACKS = null;
    HTMLElement.prototype.DOUBLE_TAP_CALLBACKS = null;
    HTMLElement.prototype.LONG_PRESS_CALLBACKS = null;
    HTMLElement.prototype.tapCount = 0;
    HTMLElement.prototype.tapListenersBound = false;
    HTMLElement.prototype.tapStartHandler = function(event) {

        var self = QMail.Viewer.instance.editor;
        
        this._tapStartReceived = Date.now();
        this._cancelTapProc();

        if(event.target.hasTapElementWithClass(QMail.CONST.QM_INSERT_AUDIO_CLASSNAME)) {
            event.stopPropagation();
            event.preventDefault();
        }
    };
    HTMLElement.prototype.tapCancelHandler = function(event) {
        this._tapStartReceived = null;
        this.tapCount = 0;
        this._cancelTapProc();
    };
    HTMLElement.prototype._cancelTapProc = function() {
        if (this._tapProc) {
            clearTimeout(this._tapProc);
        }
        this._tapProc = null;
    };
    HTMLElement.prototype.tapEndHandler = function(event) {
        var now = Date.now();
        this.tapCount++;
        this._cancelTapProc();
        var self = this;
        if (this.tapCount > 0 && this._tapStartReceived && (now - this._tapStartReceived) < this.TAP_TIMEOUT) {
            this._tapProc = setTimeout(function() {
                self.processCallbacks(event);
                self.tapCancelHandler();
            }, this.TAP_DELAY);
        } else {
            if(this.tapCount > 0 && this._tapStartReceived && (now - this._tapStartReceived) > this.LONG_PRESS_TIME) {
                this.processLongPressCallbacks(event);
            }
            this.tapCancelHandler();
        }
    };

    HTMLElement.prototype.processLongPressCallbacks = function(event) {
        var i, callback, callbackArray;
        callbackArray = this.LONG_PRESS_CALLBACKS;

        if (callbackArray) {
            for (i = 0; i < callbackArray.length; i++) {
                callback = callbackArray[i];
                if (typeof callback == 'function') {
                    callback(event);
                }
            }
        }
    }

    HTMLElement.prototype.processCallbacks = function(event) {
        var i, callback, callbackArray;
        if (this.tapCount == 2) {
            callbackArray = this.DOUBLE_TAP_CALLBACKS;
        } else if (this.tapCount == 1) {
            callbackArray = this.TAP_CALLBACKS;
        }
        if (callbackArray) {
            for (i = 0; i < callbackArray.length; i++) {
                callback = callbackArray[i];
                if (typeof callback == 'function') {
                    callback(event);
                }
            }
        }
    };
    HTMLElement.prototype.addTapEventListener = function(callback, capture) {
        if (typeof callback != 'function') {
            return;
        }
        this.TAP_CALLBACKS = this.TAP_CALLBACKS ? this.TAP_CALLBACKS : [];
        this.TAP_CALLBACKS.push(callback);
        this._createBindings();
    };
    HTMLElement.prototype.addDoubleTapEventListener = function(callback, capture) {
        if (typeof callback != 'function') {
            return;
        }
        this.DOUBLE_TAP_CALLBACKS = this.DOUBLE_TAP_CALLBACKS ? this.DOUBLE_TAP_CALLBACKS : [];
        this.DOUBLE_TAP_CALLBACKS.push(callback);
        this._createBindings();
    };
    HTMLElement.prototype.addLongPressEventListener = function(callback, capture) {
        if (typeof callback != 'function') {
            return;
        }
        this.LONG_PRESS_CALLBACKS = this.LONG_PRESS_CALLBACKS ? this.LONG_PRESS_CALLBACKS : [];
        this.LONG_PRESS_CALLBACKS.push(callback);
        this._createBindings();
    };
    HTMLElement.prototype._createBindings = function() {
        if (this.tapListenersBound) {
            return;
        }
        this.addEventListener("touchstart", this.tapStartHandler, false);
        this.addEventListener("touchmove", this.tapCancelHandler, false);
        this.addEventListener("touchcancel", this.tapCancelHandler, false);
        this.addEventListener("touchend", this.tapEndHandler, false);
    };
    HTMLElement.prototype.removeTapEventListener = function(callback, capture) {
        if (typeof callback == 'function') {
            var callbackIndex = this.TAP_CALLBACKS.indexOf(callback);
            if (callbackIndex >= 0) {
                this.TAP_CALLBACKS.splice(callbackIndex, 1);
            }
        } else {
            this.TAP_CALLBACKS = [];
        }
        if (this.TAP_CALLBACKS.length === 0) {
            this.removeEventListener("touchstart", this.tapStartHandler, false);
            this.removeEventListener("touchmove", this.tapCancelHandler, false);
            this.removeEventListener("touchcancel", this.tapCancelHandler, false);
            this.removeEventListener("touchend", this.tapEndHandler, false);
            this.tapListenersBound = false;
        }
    };

    HTMLElement.prototype.countChildrenWithContent = function countChildrenWithContent() {
        var childCount = 0;
        var children = this.childNodes;
        for (var c = 0; c < children.length; c++) {
            var child = children[c];
            if (!child) {
                continue;
            }
            if (child.nodeType == Node.TEXT_NODE && child.textContent.trim().length === 0) {
                continue;
            }
            childCount++;
        }
        return childCount;
    };

    HTMLElement.prototype.getNestedFormatNode = function() {
        var keys = Object.keys(this.FORMAT_NODES);
        var query = [];
        for (var i = 0; i < keys.length; i++) {
            var k = keys[i];
            query.push(k + " " + k);
        }
        query = query.join(",");
        return this.querySelector(query);
    };

    HTMLElement.prototype.collapseNestedFormatNodes = function() {
        void(0);
        var node, parent, lastNode;
        while ((node = this.getNestedFormatNode())) {
            if (node == lastNode) {
                break;
            }
            lastNode = node;
            parent = node.getParentElementByName(node.nodeName);
            if (!parent) {
                void(0);
                break;
            }
            parent.collapseNestedElement(node, true);
        }
    };

    HTMLElement.prototype.isFormatNode = function isFormatNode() {
        return (this.FORMAT_NODES[this.nodeName] !== undefined) ? true: false;
    };

    HTMLElement.prototype.isContentNode = function isContentNode() {
        if (this.CONTENT_NODE_NAMES[this.nodeName] !== undefined) {
            return true;
        }
        else if (this.classList.contains(this.ATTACHMENT_CLASSNAME) || this.classList.contains(this.MEDIA_CLASSNAME) || this.classList.contains(this.CRYPT_CLASSNAME) || this.classList.contains(this.INK_CLASSNAME)) {
            return true;
        }
        return false;
    };

    HTMLElement.prototype.getInnerContentNode = function getInnerContentNode() {
        var element = this;
        var found = null;
        var current = element;
        var childCount = 0;
        while (current && ((childCount = current.countChildrenWithContent()) == 1 || (childCount == 2 && current.children[1] && current.children[1].nodeName == "BR"))) {
            var child = current.children[0];
            if (!child) {
                break;
            }
            if (child.isContentNode()) {
                break;
            }
            current = child;
            found = child;
        }
        return found;
    };

    HTMLElement.prototype.collapseNestedElement = function(stopNode, ignoreFormatNodes) {
        void(0);
        var element = this;
        if (!ignoreFormatNodes && element.isFormatNode()) {
            void(0);
            return false;
        }
        var innerNode = stopNode || this.getInnerContentNode(element);
        if (element == innerNode) {
            void(0);
            return false;
        }
        void(0);
        var current = element.children[0];
        var computedAttrs = ["padding-left", "padding-right", "padding-top", "padding-bottom", "margin-left", "margin-right", "margin-top", "margin-bottom", "font-size", "font-color", "font-weight"];
        var childCount = 0;
        void(0);
        while (current && ((childCount = current.countChildrenWithContent()) == 1 || (childCount == 2 && current.children[1].nodeName == "BR"))) {
            if (!ignoreFormatNodes && current.isFormatNode()) {
                element.innerHTML = current.outerHTML;
                return true;
            }
            var computedStyle = window.getComputedStyle(current);
            if (computedStyle) {
                for (var i = 0; i < computedAttrs.length; i++) {
                    var attr = computedAttrs[i];
                    var val = computedStyle.getPropertyValue(attr);
                    if (val) {
                        element.style[attr] = val;
                    }
                }
            }
            element.style.cssText += current.style.cssText;
            var child = current.children[0];
            if (!child) {
                break;
            }
            current = child;
            if (current == innerNode) {
                element.innerHTML = (innerNode.nodeType == Node.TEXT_NODE) ? innerNode.textContent: innerNode.innerHTML;
                break;
            }
        }
        return true;
    };

    HTMLElement.prototype.isListNode = function isListNode() {
        return this.LIST_NODES[this.nodeName] !== undefined;
    };

    HTMLElement.prototype.collapse = function(preserveStyles) {
        var child = this;
        var s;
        while (child.nodeType == Node.ELEMENT_NODE && !child.isListNode() && child.countChildrenWithContent() == 1 && !child.isSpecialElement()) {
            child = child.childNodes[0];
            if (child.nodeType == Node.ELEMENT_NODE && child.nodeName != "IMG" && preserveStyles && !child.isSpecialElement()) {
                for (s in child.style) {
                    this.style[s] = child.style[s];
                }
            }
        }
        if (child && child !== this && child.nodeName != "IMG") {
            child.remove();
            this.innerHTML = "";
            if (child.nodeType == Node.ELEMENT_NODE) {
                if (child.isListNode()) {
                    this.appendChild(child);
                }
                else if (!child.isSpecialElement()) {
                    while (child.childNodes.length > 0) {
                        this.appendChild(child.childNodes[0]);
                    }
                }
            }
            else {
                this.appendChild(child);
            }
        }
    };

    HTMLElement.prototype.offset =  function(){
      var obj = this.getBoundingClientRect();
      return {
        left: obj.left + window.pageXOffset,
        top: obj.top + window.pageYOffset,
        width: Math.round(obj.width),
        height: Math.round(obj.height)
      }
    }

    HTMLElement.prototype.hasClass =  function(cls){
        return this.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));  
    }

    HTMLElement.prototype.addClass = function(cls) {
        if (!this.hasClass(cls)) {
            this.className += " " + cls;
        }
        return this;
    }

    HTMLElement.prototype.removeClass = function(cls) {
        if (this.hasClass(cls)) {
            var reg = new RegExp('(\\s|^)'+ cls + '(\\s|$)');
            this.className = this.className.replace(reg,' ');
        }
        return this;
    }

    HTMLElement.prototype.insertAfter = function(newElement,targetElement) {
        var parent = targetElement.parentNode;
        if(parent.lastchild == targetElement) {
            parent.appendChild(newElement);
        } else {
            parent.insertBefore(newElement, targetElement.nextSibling);
        }
        return this;
    }
}

(function() {
    var r = document.createRange();
    var _RangePrototype = r.constructor.prototype;
    _RangePrototype.equals = function equals(range) {
        if (!range) {
            return false;
        }
        if (range.collapsed != this.collapsed) {
            return false;
        }
        if (! (range.startContainer == this.startContainer && range.startOffset == this.startOffset)) {
            return false;
        }
        if (! (range.endContainer == this.endContainer && range.endOffset == this.endOffset)) {
            return false;
        }
        return true;
    };
    _RangePrototype.getHTML = function getHTML() {
        var d = document.createElement("div");
        d.appendChild(this.cloneContents(true));
        return d.innerHTML;
    };
    _RangePrototype.getCommonAncestorElement = function getCommonAncestorElement() {
        var container = this.commonAncestorContainer;
        if (container && container.nodeType != Node.ELEMENT_NODE) {
            container = container.parentElement;
        }
        return container;
    };
    _RangePrototype.describe = function describe() {
        var txt = this.cloneContents().textContent;
        if (txt.length > 16) {
            txt = txt.substring(0, 13) + "...";
        }
        var str = "[DOMRange] " + txt;
        var nodes = ["startContainer", "endContainer"];
        var offsets = ["startOffset", "endOffset"];
        var parts = [];
        for (var i = 0; i < nodes.length; i++) {
            var nodeType = nodes[i];
            var offsetType = offsets[i];
            var nodeName = (this[nodeType]) ? this[nodeType].nodeName: this[nodeType];
            parts.push(nodes[i] + ": " + nodeName + "@" + this[offsetType]);
        }
        str += "\n  " + parts.join("\n  ") + "\n";
        return str;
    };
    _RangePrototype.getAbsoluteBoundingClientRect = function getAbsoluteBoundingClientRect() {
        var rect = Rect.fromObject(this.getBoundingClientRect());
        rect.transpose(window.pageXOffset, window.pageYOffset);
        return rect;
    };
    _RangePrototype.scrollIntoViewIfNeeded = function scrollIntoViewIfNeeded() {
        var rect = this.getAbsoluteBoundingClientRect();
        rect.scrollIntoViewIfNeeded();
    };
})();

//////////////////begin selection addions//////////////////////////////
var _DOMSelectionProto_ = window.getSelection().__proto__;
_DOMSelectionProto_.isSelectionWithContent = function isSelectionWithContent() {
    if (this.isCollapsed) {
        return false;
    }
    var r = this.getRangeAt(0);
    if (!r) {
        return false;
    }
    var d = document.createElement("div");
    d.appendChild(r.cloneContents(true));
    return d.isNodeWithContent();
};
_DOMSelectionProto_.resetSelection = function resetSelection() {
    this.setBaseAndExtent(null, 0, null, 0);
};
_DOMSelectionProto_.hasValidSelection = function hasValidSelection() {
    return (this.baseNode && this.extentNode) ? true: false;
};
_DOMSelectionProto_.describe = function describe() {
    var parts = [];
    var nodes = ["baseNode", "extentNode", "anchorNode", "focusNode"];
    var offsets = ["baseOffset", "extentOffset", "anchorOffset", "focusOffset"];
    for (var i = 0; i < nodes.length; i++) {
        var node = this[nodes[i]];
        var offset = this[offsets[i]];
        if (node && node.nodeType == Node.ELEMENT_NODE) {
            parts.push(nodes[i] + ": " + offset + "@" + node.outerHTML);
        }
        else {
            parts.push(nodes[i] + ": " + offset + "@" + node);
        }
    }
    return "DOMSelection: (" + ((this.isCollapsed) ? "": "not ") + "collapsed)\n" + parts.join("\n");
};
_DOMSelectionProto_.querySelector = function querySelector(selector) {
    if (this.rangeCount > 0) {
        var r = this.getRangeAt(0);
        var commonAncestorContainer = r.getCommonAncestorElement();
        if (commonAncestorContainer) {
            var result = commonAncestorContainer.querySelector(selector);
            if (result && r.intersectsNode(result)) {
                return result;
            }
        }
    }
    return null;
};
_DOMSelectionProto_.querySelectorAll = function querySelectorAll(selector) {
    var result = [];
    if (this.rangeCount > 0) {
        var r = this.getRangeAt(0);
        var commonAncestorContainer = r.getCommonAncestorElement();
        if (commonAncestorContainer) {
            var found = commonAncestorContainer.querySelectorAll(selector);
            for (var i = 0; i < found.length; i++) {
                var node = found[i];
                if (r.intersectsNode(node)) {
                    result.push(node);
                }
            }
        }
    }
    return result;
};
_DOMSelectionProto_.getFirstNode = function getFirstNode() {
    var baseNode = this.baseNode;
    if (!baseNode) {
        return baseNode;
    }
    if (baseNode.nodeType != Node.ELEMENT_NODE) {
        return baseNode;
    }
    return baseNode.childNodes[this.baseOffset];
};
_DOMSelectionProto_.getLastNode = function getLastNode() {
    var extentNode = this.extentNode;
    if (!extentNode) {
        return extentNode;
    }
    if (extentNode.nodeType != Node.ELEMENT_NODE) {
        return extentNode;
    }
    return extentNode.childNodes[this.extentOffset];
};

//////////////////begin padding addions//////////////////////////////
function Padding(top, right, bottom, left) {
    this.initialize(top, right, bottom, left);
}
Padding.prototype.top = 0;
Padding.prototype.right = 0;
Padding.prototype.bottom = 0;
Padding.prototype.left = 0;
Padding.prototype.initialize = function(top, right, bottom, left) {
    if (typeof top == 'number') {
        this.top = this.right = this.bottom = this.left = top;
    }
    if (typeof right == 'number') {
        this.right = this.left = right;
    }
    if (typeof bottom == 'number') {
        this.bottom = bottom;
    }
    if (typeof left == 'number') {
        this.left = left;
    }
};
Padding.prototype.equals = function(padding) {
    if (!padding || !(padding instanceof Padding)) {
        return false;
    }
    for (var i in this) {
        if (typeof this[i] == 'function') {
            continue;
        }
        if (this[i] != padding[i]) {
            return false;
        }
    }
    return true;
};
Padding.prototype.toJSON = function() {
    return {
        left: this.left,
        top: this.top,
        right: this.right,
        bottom: this.bottom
    };
};
Padding.prototype.toString = function() {
    return this.constructor.name + JSON.stringify(this);
};
Padding.fromObject = function(obj) {
    var padding = new this();
    if (!obj || typeof obj != 'object') {
        return padding;
    }
    for (var prop in obj) {
        if (this.prototype.hasOwnProperty(prop) && typeof this.prototype[prop] == 'number') {
            padding[prop] = obj[prop];
        }
    }
    return padding;
};

//////////////////begin Rect addions//////////////////////////////
function Rect(left, top, right, bottom) {
    this.initialize(left, top, right, bottom);
}

Rect.fromObject = function(obj) {
    var rect = new this();
    if (obj && typeof obj == 'object') {
        var attrs = ["top", "left", "right", "bottom"];
        var i, attr;
        for (i = 0; i < attrs.length; i++) {
            attr = attrs[i];
            if (typeof obj[attr] != 'number') {
                return rect;
            }
            rect[attr] = obj[attr];
        }
    }
    return rect;
};
Rect.prototype.left = 0;
Rect.prototype.top = 0;
Rect.prototype.right = 0;
Rect.prototype.bottom = 0;
Rect.prototype.initialize = function(left, top, right, bottom) {
    if (typeof left == 'number') {
        this.left = left;
    }
    if (typeof top == 'number') {
        this.top = top;
    }
    if (typeof right == 'number') {
        this.right = right;
    }
    if (typeof bottom == 'number') {
        this.bottom = bottom;
    }
    this.__defineGetter__("width", this.getWidth);
    this.__defineGetter__("height", this.getHeight);
    this.__defineGetter__("midPoint", this.getMidPoint);
};
Rect.prototype.getWidth = function() {
    return this.right - this.left;
};
Rect.prototype.getHeight = function() {
    return this.bottom - this.top;
};
Rect.prototype.transpose = function(x, y) {
    if (typeof x == 'number') {
        this.left += x;
        this.right += x;
    }
    if (typeof y == 'number') {
        this.top += y;
        this.bottom += y;
    }
};

Rect.prototype.scale = function(scale) {
    this.left *= scale;
    this.right *= scale;
    this.top *= scale;
    this.bottom *= scale;
};

Rect.prototype.getMidPoint = function() {
    return {
        x: this.left + this.width / 2,
        y: this.top + this.height / 2
    };
};
Rect.prototype.addPadding = function(padding) {
    if (padding instanceof Padding) {
        this.left -= padding.left;
        this.right += padding.right;
        this.top -= padding.top;
        this.bottom += padding.bottom;
    }
    return this;
};
Rect.prototype.removePadding = function(padding) {
    if (padding instanceof Padding) {
        this.left += padding.left;
        this.right -= padding.right;
        this.top += padding.top;
        this.bottom -= padding.bottom;
    }
    return this;
};
Rect.prototype.isEmpty = function() {
    return (this.width * this.height === 0) ? true : false;
};
Rect.prototype.isEqual = function(rect) {
    if (rect && typeof rect == 'object') {
        if (this.left === rect.left && this.top === rect.top && this.right === rect.right && this.bottom === rect.bottom) {
            return true;
        }
    }
    return false;
};
Rect.prototype.intersectsRect = function(rect) {
    if (!rect || rect.isEmpty() || this.isEmpty()) {
        return false;
    }
    if (rect.right < this.left || rect.left > this.right) {
        return false;
    }
    if (rect.top > this.bottom || rect.bottom < this.top) {
        return false;
    }
    return true;
};
Rect.prototype.intersectionWithRect = function(rect) {
    if (!this.intersectsRect(rect)) {
        return new Rect();
    }
    var left = Math.max(this.left, rect.left);
    var top = Math.max(this.top, rect.top);
    var right = Math.min(this.right, rect.right);
    var bottom = Math.min(this.bottom, rect.bottom);
    return new Rect(left, top, right, bottom);
};
Rect.prototype.toJSON = function() {
    return {
        left: this.left,
        top: this.top,
        right: this.right,
        bottom: this.bottom,
        width: this.width,
        height: this.height
    };
};
Rect.prototype.toString = function() {
    return this.constructor.name + JSON.stringify(this);
};

