/**
 * created by flyhuang 
 * 编辑器对象定义，主要负责光标跟随屏幕、插入文档对象
 */

(function(){

var webContentOffset = {
    x : 0 ,
    y : 0
}


QMail.Editor = function(options) {

    this.opts = QMail.Util.extend({
        rootElement : null
    },options);

    this.init();
}

//滚动调用函数的来源
QMail.Editor.scrollSourceEnum = {
    focus : 1 ,
    keyup : 2 , 
    keyboardChanged : 3,
    checkProc : 4,
    touchImg  : 5,
    resetHtml : 6
}

QMail.Editor.prototype.DEFAULT_CARET_MARKER_HEIGHT  = 20;
QMail.Editor.prototype.defaultVisbleHeight          = 200;
QMail.Editor.prototype.defaultVisbleWidth           = 290;
QMail.Editor.prototype._spaceUponKeyboard           = 20;   
QMail.Editor.prototype._ignoresChangeCount          = 0;
QMail.Editor.prototype._selectionToEndWhenWired     = true;
QMail.Editor.prototype._hasChanges                  = false;
QMail.Editor.prototype._domChangeEvent              = false;
QMail.Editor.prototype._intervalCheckTimer          = null;
QMail.Editor.prototype._hasEditingStarted           = false;
QMail.Editor.prototype._scrollTimeHandler           = false;
QMail.Editor.prototype._currentPlayingAudioAttach   = null;

QMail.Editor.prototype.init = function() {

    var self = this;
    this._rootElement = this.opts.rootElement;
    this._tempPlaceDivs = {}; //用于占位的div
    this.resetVisbleRect();
    this.__defineGetter__("rootElement", this.getRootElement);
    this.__defineGetter__("isFocus", this.getIsFocus);
    this.__defineGetter__("needScale", this.getNeedScale);

    this.__defineGetter__("disableChanged", this.getDisableChanged);
    

    window.onbeforeunload = function() {
        self.stopIntevalCheck();
        QMail.Debug.log('onbeforeunload');
    }
}

QMail.Editor.prototype.getRootElement = function getRootElement() {
    if (!this._rootElement) {
        this._rootElement = document.body;
    }
    return this._rootElement;
};

QMail.Editor.prototype.focus = function() {
    this.rootElement.focus();
}

QMail.Editor.prototype.startEdit = function() {

    var self = this;

    if(!this.rootElement.getAttribute("contentEditable")) {
        this.rootElement.setAttribute("contentEditable", true);
    }

    //绑定事件
    if(!this._hasEditingStarted) {
      this._bindEvents();
    }

    //设置标记位
    this._hasEditingStarted = true;
    this.startIntevalChcek();

    this.trigger('startEdit');
}

QMail.Editor.prototype.stopEdit = function() {

    if(this.isFocus) {
        this.rootElement.blur();
    }

    this._unbindEvents();
    this._hasEditingStarted = false;
    this.trigger('stopEdit');
}

QMail.Editor.prototype.startIntevalChcek = function() {

    var self = this;

    this.stopIntevalCheck();

    this._intervalCheckTimer = setInterval(function(){
        self._checkProc();
    },100);
}

QMail.Editor.prototype._checkProc = function() {
    
    QMail.Debug.log('_checkProc');

    if(this._domChangeEvent) {
        this.scrollToCaret(0 , QMail.Editor.scrollSourceEnum.checkProc);
        this._domChangeEvent = false;

        //调整当前附件保持一致
        QMail.AttachmentManager.shareInstance.consitentAttachmentsInCaseChanges();
        
        QMail.Debug.log('_dom changed');
    }
}

QMail.Editor.prototype.stopIntevalCheck = function() {

    if(this._intervalCheckTimer) {
       clearInterval(this._intervalCheckTimer);
    }
}

QMail.Editor.prototype.setVisibleRect = function(left , top , right, bottom) {
    this._visibleRect = new Rect(left, top, right, bottom);
}

QMail.Editor.prototype.resetVisbleRect = function() {
    this.setVisibleRect(0, 0,  this.defaultVisbleWidth, this.defaultVisbleHeight);
}

QMail.Editor.prototype.updateCurrentOffset = function(x , y) {

    this._currentScrollOffset = {
        x : x,
        y : y
    }

    QMail.Debug.log('updateCurrentOffset:' + x + ' ' + y);
}

QMail.Editor.prototype.setDefaultVisibleHeight = function(height, x , y) {

    this.updateCurrentOffset(x , y);

    if(height) {
        this.defaultVisbleHeight = height;
        this.resetVisbleRect();
    }

    if(!this._initialOffset && y < 0) {
        this._initialOffset = {
            x : x,
            y : y,
            h : this.defaultVisbleHeight + y
        };
    }

    QMail.Debug.log('setDefaultVisibleHeight:' + height + ' ' + this.defaultVisbleHeight);
    if(this.isFocus) {
        this.resetCaretToLastTouchElement();
    }
}

QMail.Editor.prototype.setInitialOffset = function(x , y ) {

    this._initialOffset = {
        x : x,
        y : y,
        h : this.defaultVisbleHeight + y
    };
}

QMail.Editor.prototype._bindEvents = function() {

    this.rootElement.addEventListener('keyup', this._onKeyup , false);
    this.rootElement.addEventListener('focus',  this._onFocus , false);
    this.rootElement.addEventListener('blur',  this._onBlur , false);
    this.rootElement.addEventListener('DOMSubtreeModified',  this._onDomSubtreeModified , false);
    this.rootElement.addTapEventListener(this._onTap, false);
    document.addEventListener("paste", this._onPaste, false);
}

QMail.Editor.prototype._unbindEvents = function() {
    this.rootElement.removeEventListener('keyup',  this._onKeyup);
    this.rootElement.removeEventListener('focus',  this._onFocus);
    this.rootElement.removeEventListener('blur',   this._onBlur);
    this.rootElement.removeEventListener('DOMSubtreeModified',   this._onDomSubtreeModified);
    this.rootElement.removeTapEventListener(this._onTap, false);
    document.removeEventListener("paste", this._onPaste, false);
}

QMail.Editor.prototype.getIsFocus = function() {
    return document.activeElement === this.rootElement;
}

QMail.Editor.prototype._onDomSubtreeModified = function(e){

    var self = QMail.Viewer.instance.editor;

    QMail.Debug.log('_onDomSubtreeModified');
    QMail.Debug.log('_ignoresChangeCount:' + self._ignoresChangeCount);

    if(!self.disableChanged) {
        self._domChangeEvent = true;
        QMail.NativeNotifier.notify('domSubtreeModifiedFromJs');
    }
}

//当用户点击时判断是否要进行focus进入编辑态
QMail.Editor.prototype.shouldEnterFocusWhenTap = function(e) {

    var self = this;
    var currentTime = new Date().getTime();

    if(e.target.isCheckboxElement()) {
        //在非编辑条件下，如果target为checkbox会导致系统默认的实现触发两次checked
        if(Math.abs(currentTime - self._lastTapTime) > 1000 && self.isFocus) {
            var checkbox = e.target;
            var selected = checkbox.getAttribute("checked");
            if(selected) {
                checkbox.checked = false;
                checkbox.setAttribute("checked", '');
            } else {
                checkbox.checked = true;
                checkbox.setAttribute("checked", "checked");
            }
        }
        self._lastTapTime = new Date().getTime();
        return false;
    }

    self._lastTapTime = new Date().getTime();
    return true;
}

QMail.Editor.prototype._onPaste = function(e) {

    var self = QMail.Viewer.instance.editor;

    setTimeout(function(){
        QMail.NativeNotifier.notify('pasteFromJs');
    },0);
    
    self.scrollToCaret(100);
}

QMail.Editor.prototype.saveAttachmentsByPaste = function(e) {

    var pasteImages = [];
    var imageElements = this.rootElement.querySelectorAll('img[src^=webkit-fake-url]');

    // <img src="webkit-fake-url://7E9C44E2-0C0B-44A1-8A6F-0777CC9E5805/imagepng">
    for (var i= 0, l= imageElements.length; i< l; i++) {
        var imageElem = imageElements[i];
        var imageSrc  = imageElem.src;
        var imageFileName = imageSrc.replace(/^webkit-fake-url:\/\/([^/]+)\/.*$/, "$1");
        var imageFileType = imageSrc.substring(imageSrc.lastIndexOf('/') + 1);

        if(imageFileType && imageFileType.indexOf('image') > -1) {

            var imageFileExt = imageFileType.replace('image','');

            //设置id为它的path，供保存后进行替换
            imageElem.setAttribute('id',imageFileName);

            pasteImages.push({
                fileName : imageFileName,
                fileExt  : imageFileExt
            });
        } 
    }
    return JSON.stringify(pasteImages);
}

QMail.Editor.prototype.markPasteImageSaved = function(imageIds , pasteImageAttachMents) {

    for (var i = 0; i < pasteImageAttachMents.length; i++) {   
        var attachInfo = pasteImageAttachMents[i];
        var imageId = imageIds[i];
        var imageElem = document.getElementById(imageId);

        if(imageElem) {
            imageElem.setAttribute('src',attachInfo.filePath);
            imageElem.removeAttribute('id');
            var imgUi = new QMail.UIAttachment(imageElem,attachInfo);
            //加入公用的文件管理器
            this._attachImageElement(imageElem , attachInfo);
            QMail.AttachmentManager.shareInstance.addAttachment(imgUi);
        }
    };
}

QMail.Editor.prototype._onTap = function(e) {

    var self = QMail.Viewer.instance.editor;

    //如果用户点击了图片，则需要微调滚动条
    if(e.target.nodeName.toLocaleLowerCase() == 'img') {
        self.scrollToCaret(0 , QMail.Editor.scrollSourceEnum.touchImg);
    } else if(e.target.hasTapElementWithClass(QMail.CONST.QM_INSERT_AUDIO_CLASSNAME)) {

        //用户点击了语音附件栏
        var element = e.target;
        var uiAttachment = QMail.AttachmentManager.shareInstance.getAttachmentById(element.getAttribute('attachId'));

        if(uiAttachment) {
            //通知object-c点击了语音，是否播放由object-c去控制，这样实现逻辑比较清晰，否则得来回交互处理异常情况的展现
            self.notifyAudioTapped(uiAttachment);
        }
    } 
    self.storeCurrentSelection();
}

QMail.Editor.prototype.notifyAudioTapped = function(uiAttachment) {

    var attachInfo = uiAttachment.attachInfo;

    QMail.Debug.log('tapAudio path:' + attachInfo.filePath);

    QMail.NativeNotifier.notify('tapAudioFromJs' , {
        elementId : uiAttachment.attachId,
        filePath  : attachInfo.filePath
    });
}

QMail.Editor.prototype.playAudio = function(audioUi) {

    //停止当前的
    this.stopAudio();

    if(audioUi) {
        this.igoresChange(true);
        audioUi.showPlaying();
        this._currentPlayingAudioAttach = audioUi;
        this.igoresChange(false);
    }
}

QMail.Editor.prototype.stopAudio = function(audioUi) {

    if(!audioUi) {
        audioUi = this._currentPlayingAudioAttach;
    }

    if(audioUi) {
        this.igoresChange(true);
        audioUi.showEnding();
        if(this._currentPlayingAudioAttach === audioUi) {
            this._currentPlayingAudioAttach = null;
        }
        this.igoresChange(false);
    }
}

QMail.Editor.prototype.loadAudio = function(audioUi) {

    if(audioUi) {
        this.igoresChange(true);
        audioUi.showLoding();
        this.igoresChange(false);
    }
}

QMail.Editor.prototype._onKeyup = function(e) {

    var self = QMail.Viewer.instance.editor;
    
    if(e.keyCode == 8)  {
        self._handleDelete();
    } 

    self.scrollToCaret(0 , QMail.Editor.scrollSourceEnum.keyup);
}

QMail.Editor.prototype._handleDelete = function() {

    var self = QMail.Viewer.instance.editor;
    var appleStyleSpan = self.getParentAppleStyleSpan();

    if (appleStyleSpan && appleStyleSpan.isEmptyNode()) {

        self.normalizeAppleStyleSpan(appleStyleSpan);

        var topmostAppleStyleElement = appleStyleSpan;
        while (topmostAppleStyleElement) {
            var _parent = topmostAppleStyleElement.parentElement;
            if (_parent.className == "Apple-style-span") {
                topmostAppleStyleElement = _parent;
            }
            break;
        }
        if (topmostAppleStyleElement.nodeName != "DIV" && topmostAppleStyleElement.nodeName != "P" && topmostAppleStyleElement.parentElement == this.rootElement) {
            document.execCommand("formatBlock", false, "div");
        }
    }
}

QMail.Editor.prototype.normalizeAppleStyleSpan = function normalizeAppleStyleSpan(element) {
    void(0);
    var currentNode = element;
    do {
        if (!currentNode.className.match(/Apple-style-span/)) {
            break;
        } else {
            if (currentNode.style.fontSize) {
                currentNode.style.fontSize = "inherit";
            }
        }
    } while (( currentNode = currentNode . parentElement ) != null);
};

QMail.Editor.prototype.getParentAppleStyleSpan = function getParentAppleStyleSpan() {
    void(0);
    var sel = window.getSelection();
    var baseNode = sel.baseNode;
    if (baseNode.nodeType != Node.ELEMENT_NODE) {
        baseNode = baseNode.parentElement;
    }
    var appleStyleSpan = null;
    var _parent = null;
    do {
        if (baseNode.className == "Apple-style-span") {
            appleStyleSpan = baseNode;
            break;
        }
        else {
            baseNode = baseNode.parentElement;
        }
    } while ( baseNode && baseNode != this . rootElement );
    return appleStyleSpan;
};

QMail.Editor.prototype.resetCaretToLastTouchElement = function() {

    var lastTouchElement = QMail.Viewer.instance.lastTouchElement;
    var resetTarget = null;

    if(lastTouchElement && lastTouchElement.nodeName.toUpperCase() == 'IMG') {
        QMail.Debug.log('_onFocus has lastTouchElement img');
        resetTarget = lastTouchElement;
    }

    if(resetTarget) {
        this.setCaretAfterElement(lastTouchElement);
        this.storeCurrentSelection();
        this.scrollToCaret(0, QMail.Editor.scrollSourceEnum.touchImg);
    } else {
        QMail.Debug.log('resetCaretToLastTouchElement');
        QMail.Debug.log(lastTouchElement);
    }
}

QMail.Editor.prototype._onFocus = function(e) {

    var self = QMail.Viewer.instance.editor;
    var delayTime = 100;

    //恢复上次的点击
    self.resetCaretToLastTouchElement();
    // self.restoreSelection();
    self.scrollToCaret(delayTime, QMail.Editor.scrollSourceEnum.focus);

    //在focus一段时间后再清空上次记录的touchElement
    setTimeout(function(){
        QMail.Viewer.instance.clearLastTouchElement();
    },2000);

    QMail.Debug.log('_onFocus');
}

QMail.Editor.prototype.igoresChange = function(igore) {

    if(igore) {
        this._ignoresChangeCount++;
    } else {
        this._ignoresChangeCount--;
    }
}

QMail.Editor.prototype.getDisableChanged = function(){
    return this._ignoresChangeCount > 0;
}

QMail.Editor.prototype._onBlur = function(e) {

    var self = QMail.Viewer.instance.editor;
    self.stopIntevalCheck();
    QMail.Viewer.instance.clearLastTouchElement();
    self._hasEditingStarted = false;
}

//滚动到当前光标显示区域
QMail.Editor.prototype.scrollToCaret = function(time , source) {
    var self = this;
    time = typeof(time) === 'number' ? parseInt(time,10) : 0;

    if(this._scrollTimeHandler) {
      clearTimeout(this._scrollTimeHandler);
    }

    QMail.Debug.log('scrollToCaret source:' + source);
   
    if(time == 0) {
        this.adjustContentOffset(function(){
            self._scrollToCaret(source);
            self.storeCurrentSelection();
        });
    } else {
        self._scrollTimeHandler = setTimeout(function() {
            self.adjustContentOffset(function(){
              self._scrollToCaret(source);
              self.storeCurrentSelection();
            });
        }, time);
    } 
}

QMail.Editor.prototype.adjustContentOffset = function(callback) {

    var self = this;

    QMail.NativeNotifier.notifyWithResponse('getWebViewOffsetFromJS' , {}, function(x , y) {

        if(self._currentScrollOffset) {
            self._currentScrollOffset.y = y;
        }

        webContentOffset.y = y;

        callback && callback();
    });
}

//@deprated : 获取当前选择区域 
QMail.Editor.prototype.getSelectionRect = function getSelectionRect(absolute) {

    void(0);
    var sel = window.getSelection();
    var rect = null;
    var r = null;
    var baseNode = sel.baseNode;
    var baseOffset = sel.baseOffset;

    try {

        this.igoresChange(true);

        if (!sel.isCollapsed) {
            void(0);
            r = sel.getRangeAt(0);
            rect = Rect.fromObject(r.getBoundingClientRect());
        } else if (sel.baseNode) {
            void(0);
            baseOffset = sel.baseOffset;
            var charRange = null;
            var txt = baseNode.textContent;
            var txtLen = txt.length;

            if (baseNode.nodeType == Node.TEXT_NODE) {
                void(0);
                if (baseOffset > 0) {
                    QMail.Debug.log('TEXT_NODE baseOffset > 0');
                    void(0);
                    charRange = document.createRange();
                    charRange.setStart(baseNode, baseOffset - 1);
                    charRange.setEnd(baseNode, baseOffset);
                    rect = charRange.getBoundingClientRect();

                    //有可能取到bottom == top的情况
                    QMail.Debug.log('rect:' + rect.top + ' ' + rect.bottom + ' ' + baseOffset + ' ' + txtLen);
                    if (rect.bottom <= rect.top) {

                        if(baseOffset < txtLen - 3) {
                            charRange.setEnd(baseNode, baseOffset + 2);
                            rect = charRange.getBoundingClientRect();
                        } else if(baseOffset > 3){
                            charRange.setStart(baseNode, baseOffset - 2);
                            charRange.setEnd(baseNode, baseOffset);
                            rect = charRange.getBoundingClientRect();
                        }
                    } 

                    if(rect) {
                        rect = new Rect(rect.right - 1, rect.top, rect.right + 1, rect.bottom);
                    }
                } else if (txtLen > 0) {
                    QMail.Debug.log('TEXT_NODE txtLen > 0');
                    void(0);
                    charRange = document.createRange();
                    charRange.setStart(baseNode, baseOffset);
                    charRange.setEnd(baseNode, baseOffset + 1);
                    rect = charRange.getBoundingClientRect();
                    if (rect) {
                        rect = new Rect(rect.left - 1, rect.top, rect.left + 1, rect.bottom);
                    }
                } else {
                    void(0);
                    rect = baseNode.parentElement.getBoundingClientRect();
                    if (rect) {
                        rect = new Rect(rect.left - 1, rect.top, rect.left + 1, rect.bottom);
                    }
                }
            } else  {
                this.igoresChange(true);
                QMail.Debug.log('begin getSelection base node not equal root');
                void(0);
                var tempDiv = document.createElement("div");
                var baseNodeStyle = window.getComputedStyle(sel.baseNode, '');
                var tempDivHeight = parseFloat(baseNodeStyle.getPropertyValue("font-size"));
                if (!tempDivHeight) {
                    tempDivHeight = 20;
                }
                tempDiv.style.cssText = "display: inline-block; position: relative; padding: 0px; margin: 0px; float: none; width: 0px; height: " + tempDivHeight + "px;";
                sel.baseNode.insertBefore(tempDiv, sel.baseNode.childNodes[sel.baseOffset]);
                rect = Rect.fromObject(tempDiv.getBoundingClientRect());
                rect.left -= 1;
                rect.right += 1;
                tempDiv.remove();
                QMail.Debug.log('end getSelection base node not equal root');   
                this.igoresChange(false);     

                //ios7 getBoundClientRect拿到的是相对的，但是range里面拿到的是绝对的，囧
                if(rect && QMail.Util.isIosVersion7() && absolute) {
                    rect.transpose(this.getScrollX(),  this.getScrollY() + Math.abs(this._initialOffset.y));
                }     
            }
        }

        if (!rect && baseNode && baseNode != this.rootElement) {
            QMail.Debug.log('!rect && baseNode && baseNode != this.rootElement');
            void(0);
            if (baseNode.nodeType == Node.ELEMENT_NODE && baseNode.childNodes.length > 0) {
                baseNode = baseNode.childNodes[baseOffset];
            }
            var prevSib = baseNode.previousSibling;
            var nextSib = baseNode.nextSibling;
            var prevSibRect, nextSibRect;
            while (prevSib || nextSib) {
                if (prevSib) {
                    prevSibRect = (typeof prevSib["getBoundingClientRect"] == 'function') ? prevSib.getBoundingClientRect() : null;
                    if (prevSibRect) {
                        void(0);
                        rect = new Rect(prevSibRect.right - 1, prevSibRect.top, prevSibRect.right + 1, prevSibRect.bottom);
                        break;
                    } else {
                        prevSib = prevSib.previousSibling;
                    }
                } else if (nextSib) {
                    nextSibRect = (typeof nextSib["getBoundingClientRect"] == 'function') ? nextSib.getBoundingClientRect() : null;
                    if (nextSibRect) {
                        void(0);
                        rect = new Rect(nextSibRect.left - 1, nextSibRect.top, nextSibRect.left + 1, nextSibRect.bottom);
                        break;
                    } else {
                        nextSib = nextSib.nextSibling;
                    }
                }
            }

            //ios7 getBoundClientRect拿到的是相对的，但是range里面拿到的是绝对的，囧
            if(rect && QMail.Util.isIosVersion7() && absolute) {
                rect.transpose(this.getScrollX(), this.getScrollY() + Math.abs(this._initialOffset.y));
            } 
        }

        QMail.Debug.log('select baseNode:' + baseOffset);
        QMail.Debug.log(baseNode);
        
    } catch (e) {
        void(0);
        void(0);
        QMail.Debug.log(e.message);
    } finally {
        this.igoresChange(false);
    }

    if (rect && absolute && !QMail.Util.isIosVersion7()) {

        var transposeY = this.getScrollY();

        if(transposeY < 0) {
            transposeY = this.getScrollY() + Math.abs(this._initialOffset.y);
        }

        rect.transpose(this.getScrollX(), transposeY);
    }
    return rect;
};

QMail.Editor.prototype.getScrollX = function() {
    return Math.floor(window.scrollX);
}

QMail.Editor.prototype.getScrollY = function() {
    return Math.floor(webContentOffset.y);
}

QMail.Editor.prototype.getVisibleRect = function getVisibleRect(absolute) {
    void(0);
    var vRect = this._visibleRect;
    vRect = Rect.fromObject(vRect);

    if (absolute) {
        var offsetX = this.getScrollX();
        var offsetY = this.getScrollY();
        vRect.transpose(offsetX, offsetY);
    }

    QMail.Debug.log('begin getVisibleRect');
    QMail.Debug.log(vRect);
    QMail.Debug.log('end getVisibleRect');
    return vRect;
};

QMail.Editor.prototype.getNeedScale = function() {
    return QMail.Viewer.viewport.needScale;
}

QMail.Editor.prototype.normalizeCaretPostion = function(pos) {

    //如果当前页面没有进行缩放则不需要移动横向滚动条
    if(!this.needScale) {
       pos.x = 0;
       QMail.Debug.log('normalizeCaretPostionX:' + pos.x);
    }

    var maxY = this.getTextHeight() - this.defaultVisbleHeight + this._spaceUponKeyboard;

    if(pos.y > maxY && pos.y > 0) {
        pos.y = maxY;
        QMail.Debug.log('normalizeCaretPostionY:' + pos.y);
    }

    return pos;
}

QMail.Editor.prototype.setSpaceUponKeyboard = function setSpaceUponKeyboard(space) {
    this._spaceUponKeyboard = space;
}

/**

  图解：

  1. bottom超过visible的bottom
  2. top 小于visible的top
  3. right 超过visieble的right
  4. left 小于visiblede的left
  ----------------------------------------
  |      visibleRect                     |
  |                                      |
  | --------------------------           |
  | |                        |           |
  | |  paddedRect            |           |
  | |                        |           | 
  | --------------------------           |
  ----------------------------------------
 */
QMail.Editor.prototype.makeRectVisible = function makeRectVisible(rect) {
    void(0);
    var vRect = this.getVisibleRect(true);
    var topOffset = 0;
    var rectPadding = new Padding(7);
    var paddedRect = Rect.fromObject(rect);
    var rectGap = 20;
    paddedRect.addPadding(rectPadding);

    if(this._currentScrollOffset && this._currentScrollOffset.y < 0) {
        vRect.top += this._currentScrollOffset.y;
        vRect.bottom += this._currentScrollOffset.y;
    } 

    if (window.pageYOffset > 0) {
        vRect.transpose(0, topOffset);
    }

    QMail.Debug.log('begin paddedRect');
    QMail.Debug.log(paddedRect);
    QMail.Debug.log('end paddedRect');

    this.trigger('makeRectVisible',paddedRect , vRect);

    void(0);
    if (paddedRect.bottom <= vRect.bottom && paddedRect.bottom > vRect.top && (paddedRect.top >= vRect.top || paddedRect.height > vRect.height) && paddedRect.right <= vRect.right && (paddedRect.right > vRect.left && paddedRect.width > vRect.width)) {
        void(0);
        return;
    }
    var newX = this.getScrollX();
    var newY = this.getScrollY();

    //20为单行的高度
    if (paddedRect.top <= vRect.top) {
        void(0);
        newY = paddedRect.top;
        QMail.Debug.log('top out of visible rect:' + paddedRect.top + ' ' + vRect.top);
    } else if(paddedRect.bottom >= vRect.bottom - this._spaceUponKeyboard){
        void(0);
        newY = paddedRect.bottom - this.defaultVisbleHeight + this._spaceUponKeyboard;
        QMail.Debug.log('bottom out of visible rect:' + paddedRect.bottom + ' ' + vRect.bottom);
    } else if(this._currentScrollOffset){
        if(window.pageYOffset <= 0) {
            newY = this._currentScrollOffset.y;
        }
    } 

    if (paddedRect.left > vRect.right) {
        void(0);
        newX = paddedRect.left - vRect.width + rectGap;
    } else if (paddedRect.left < vRect.left) {
        void(0);
        newX = Math.max(0, paddedRect.left) - rectGap;
    } else if (vRect.right < paddedRect.right && paddedRect.left > vRect.left + paddedRect.width) {
        void(0);
        newX += paddedRect.right - vRect.right - rectGap;
    } 

    void(0);

    var bodyScrollHeight = document.body.scrollHeight;

    if(this._initialOffset && this._initialOffset.h > 0) {
       var firstMax = this._initialOffset.h;

       //当用户backspace删除时如果当前光标处于一开始的可见区域范围内才重设置contentOffset
       if(paddedRect.top <= vRect.top &&
          paddedRect.top < (firstMax - this._spaceUponKeyboard - this.DEFAULT_CARET_MARKER_HEIGHT) && 
          paddedRect.height < this.DEFAULT_CARET_MARKER_HEIGHT * 2 &&
          paddedRect.bottom < vRect.bottom) {
            // QMail.Debug.log('firstMax:' + firstMax + ' vrectTop:' + vRect.top + ' paddedRect:' + paddedRect.top + ' ' + paddedRect.bottom);
            newY = this._initialOffset.y;
        } else if(newY < this._initialOffset.y) {
            newY = this._initialOffset.y;
        } else if(paddedRect.bottom < firstMax - this._spaceUponKeyboard) {
            newY = this._initialOffset.y;
        }
    }

    return {
        x : newX,
        y : newY
    }
};

//滚动到当前光标处
QMail.Editor.prototype._scrollToCaret = function(source) {

    if(!this.isFocus) {
        return;
    }

    if(!this._lastScrollTime) {
        this._lastScrollTime = new Date().getTime();
    }

    var currentTime = new Date().getTime();

    //checkProc是为了兼容越狱的第三方键盘无法通过keyup去更新光标，所以做了定时器
    if(Math.abs(currentTime - this._lastScrollTime) < 500 && 
       source == QMail.Editor.scrollSourceEnum.checkProc) {
        return;
    }

    //重置可视区域
    var self = this;

    this.resetVisbleRect();

    var caretPos , wired = false , wiredNum = 99999;
    var selectionRect = this.getSelectionRect(true);

    QMail.Debug.log('begin selectionRect:');
    QMail.Debug.log(selectionRect);
    QMail.Debug.log('end selectionRect:');

    if(selectionRect) {
        void(0);
        if(Math.abs(selectionRect.bottom) > wiredNum) {
            wired = true;
            //此时到了特殊异常逻辑了，很无奈啊
            if(this._lastScrollY) {

                var adjustY = this._lastScrollY - this.defaultVisbleHeight * 2;

                if(this._lastOffsetHeight) {
                    var currentOffsetHeight = this._rootElement.offsetHeight;
                    if(currentOffsetHeight < this._lastOffsetHeight) {
                        adjustY = this._lastScrollY - (this._lastOffsetHeight - currentOffsetHeight);
                    }
                    this._lastOffsetHeight = undefined;
                }

                this.scrollTo({
                    x : this._lastScrollX,
                    y : adjustY
                }, true);
                return;
            }

            if(this._selectionToEndWhenWired) {
                this.setSelectionAtEnd();       
            }
        } else {
            caretPos = this.makeRectVisible(selectionRect);
        }
    } else {
        wired = true;
    }

    //否则设置到最末尾
    if(wired) {
        QMail.Debug.warn('wired');
        if(this._selectionToEndWhenWired) {
            this.setSelectionAtEnd();       
        }
        selectionRect = this.getSelectionRect(true);
        caretPos = this.makeRectVisible(selectionRect);

        if(caretPos) {
            caretPos.y = caretPos.y > 20 ? caretPos.y - 20 : caretPos.y;
        }
    }
    
    if(caretPos) {
        //调整position，如果页面没缩放就不改left
        caretPos = this.normalizeCaretPostion(caretPos);

        this.scrollTo({
            x : caretPos.x,
            y : caretPos.y
        }, true);
    }
}

QMail.Editor.prototype.scrollTo = function(point , animated) {

    //调用原生代码进行滚动
    QMail.Debug.log('scrollTo x:' + point.x + ' y:' + point.y);
    
    this._lastScrollY = point.y;
    this._lastScrollX = point.x;
    this._lastOffsetHeight = this._rootElement.offsetHeight;

    QMail.NativeNotifier.notify('setWebViewOffsetFromJS', {
      x : point.x,
      y : point.y
    });

    this._lastScrollTime = new Date().getTime();
}

QMail.Editor.prototype.insertAttachment = function(attachInfo , otherOption) {

    if(attachInfo.fileType == 0) {
        this.focus();
        this.insertImage(attachInfo , otherOption);

    } else if(attachInfo.fileType == 1) {

        var uiManager = QMail.UIManager.shareInstance;

        uiManager.resourcesReady(function() {
            QMail.Viewer.instance.editor.focus();
            QMail.Viewer.instance.editor.insertAudio(attachInfo,otherOption);
        });
    }
}


QMail.Editor.prototype._createImageElement = function(attachInfo , otherOption) {
    var img = document.createElement('img');
    img.setAttribute('src', attachInfo.filePath);
    img.className = QMail.CONST.QM_INSERT_IMAGE_CLASS_NAME;
    img.setTitle(attachInfo.fileName);
    // QMail.Viewer.viewport.adjustImg(img , otherOption.width, otherOption.height);
    QMail.AttachmentManager.shareInstance.addAttachInfoToElement(attachInfo , img);
    return img;
}

QMail.Editor.prototype._attachImageElement = function(img , attachInfo , otherOption) {
    img.setAttribute('src', attachInfo.filePath);
    img.className = QMail.CONST.QM_INSERT_IMAGE_CLASS_NAME;
    img.setTitle(attachInfo.fileName);
    // QMail.Viewer.viewport.adjustImg(img , otherOption.width, otherOption.height);
    QMail.AttachmentManager.shareInstance.addAttachInfoToElement(attachInfo , img);
    return img;
}

QMail.Editor.prototype.insertImage = function(attachInfo , otherOption) {
    
    var self = this;

    this.igoresChange(true);

    var imageElementShouldAdd = this._createImageElement(attachInfo , otherOption);
    var imageElementAdded = this.insertElement(imageElementShouldAdd);

    if(imageElementAdded) {

         //防止之前没有宽度和高度导致光标无法调整正确
        if(imageElementAdded) {
            if(otherOption.width <= 0 || otherOption.height <= 0) {
                var tempImage = new Image();
                tempImage.onload = function() {
                    var width = tempImage.width;
                    var height = tempImage.height;
                    imageElementAdded.style.minWidth = '';
                    imageElementAdded.style.minHeight = '';
                    self.editor.scrollToCaret(50);
                    QMail.NativeNotifier.notify('adjustContentSizeToFitFromJs');
                }
                tempImage.src = otherOption.src;
            } else {
                this.scrollToCaret(0);
                QMail.NativeNotifier.notify('adjustContentSizeToFitFromJs');
            }

            var imgUi = new QMail.UIAttachment(imageElementAdded,attachInfo);
            //加入公用的文件管理器
            QMail.AttachmentManager.shareInstance.addAttachment(imgUi);
        } 

        //设置光标到节点之后
        this.setCaretAfterElement(imageElementAdded);
        //保存当前光标用于下次插入
        this.storeCurrentSelection();
        //添加完后调整滚动区域
        this.scrollToCaret(100);
    } 

    this.igoresChange(false);

    return imageElementAdded;
}

QMail.Editor.prototype._createAudioElement = function(attachInfo) {

    var qmAudioDiv = document.createElement(QMail.CONST.QM_INSERTED_AUDIO_TAG_NAME);
    qmAudioDiv.addClass(QMail.CONST.QM_INSERT_AUDIO_CLASSNAME);
    qmAudioDiv.addClass(QMail.CONST.QM_INSERT_AUDIO_END_CLASSNAME);
    QMail.AttachmentManager.shareInstance.addAttachInfoToElement(attachInfo , qmAudioDiv);
    return qmAudioDiv;
}

QMail.Editor.prototype.insertAudio = function(attachInfo) {

    var audioElm    = this._createAudioElement(attachInfo);

    this.igoresChange(true);

    var addAudioElm = this.insertElement(audioElm);

    if(addAudioElm) {
        var audioUi = new QMail.UIAudioAttachment(addAudioElm , attachInfo);
        //加入公用的文件管理器
        QMail.AttachmentManager.shareInstance.addAttachment(audioUi);
        
        audioUi.showEnding();
        //设置光标到节点之后
        this.setCaretAfterElement(addAudioElm);
        //保存当前光标用于下次插入
        this.storeCurrentSelection();
        //添加完后调整滚动区域
        this.scrollToCaret(100);
    }

    this.igoresChange(false);

    return addAudioElm;
}

QMail.Editor.prototype.insertElement = function insertElement(e) {
    void(0);

    e.addClass(QMail.CONST.QM_INSERTED_ELEMENT_CLASSNAME);

    var sel = window.getSelection();

    //恢复选择区域
    this.igoresChange(true);
    this.restoreSelection();
    var changed = document.execCommand("insertHTML", false, e.outerHTML);

    QMail.Debug.log('insertHTML: ' + e.outerHTML);
    if (!changed) {
        QMail.Debug.log('insertHTML failure');
        return undefined;
    }
    var ins = document.querySelector("." + QMail.CONST.QM_INSERTED_ELEMENT_CLASSNAME);
    if (ins) {
        ins.removeClass(QMail.CONST.QM_INSERTED_ELEMENT_CLASSNAME);
        //设置光标到待添加的节点之后
        QMail.Debug.log('insertElementSuccess');
    }

    this.igoresChange(false);

    return ins;
};

QMail.Editor.prototype.setCaretAfterElement = function setCaretAfterElement(e) {
    var parent = e.parentElement;
    if (!parent) {
        return;
    }
    var children = Array.prototype.slice.call(parent.childNodes);
    QMail.Debug.log(children);
    QMail.Debug.log(e);
    var eIndex = children.indexOf(e);
    var sel = window.getSelection();
    sel.setBaseAndExtent(parent, eIndex + 1, parent, eIndex + 1);
    QMail.Debug.log('setCaretAfterElement index:' + eIndex);
};

//保存当前光标的选区
QMail.Editor.prototype.storeCurrentSelection = function storeCurrentSelection() {
    void(0);
    var sel = window.getSelection();
    if (sel && sel.baseNode) {
        this._currentSelection = {
            "anchorNode": sel.anchorNode,
            "anchorOffset": sel.anchorOffset,
            "baseNode": sel.baseNode,
            "baseOffset": sel.baseOffset,
            "focusNode": sel.focusNode,
            "focusOffset": sel.focusOffset,
            "extentNode": sel.extentNode,
            "extentOffset": sel.extentOffset,
            "isCollapsed": sel.isCollapsed
        };
        this._currentNode = sel.focusNode;
        this._currentOffset = sel.focusOffset;
    }
};

QMail.Editor.prototype.isStoredSelectionValid = function isStoredSelectionValid() {
    void(0);
    var curSel = this._currentSelection;
    if (!curSel) {
        return false;
    }
    var rootRange = document.createRange();
    rootRange.selectNode(this.rootElement);
    if (curSel.anchorNode && curSel.focusNode && rootRange.intersectsNode(curSel.anchorNode) && rootRange.intersectsNode(curSel.focusNode)) {
        return true;
    }
    return false;
};

//恢复选择区域
QMail.Editor.prototype.restoreSelection = function restoreSelection(invalidateEnd) {
    void(0);
    try {
        var sel = window.getSelection();
        //如果原来的选区不对则滚动到最末尾去
        if (!this.isStoredSelectionValid()) {
            void(0);
            if(invalidateEnd) {
                this.setSelectionAtEnd();
                this.storeCurrentSelection();
            }
        } else {
            var curSel = this._currentSelection;
            var baseNode = curSel.baseNode;
            var baseOffset = curSel.baseOffset;
            var extentNode = curSel.extentNode;
            var extentOffset = curSel.extentOffset;
            if (!baseNode) {
                void(0);
            } else {
                var baseChildCount = (baseNode.nodeType == Node.ELEMENT_NODE) ? baseNode.childNodes.length : baseNode.textContent.length;
                var extentChildCount = (extentNode.nodeType == Node.ELEMENT_NODE) ? extentNode.childNodes.length : extentNode.textContent.length;
                if (baseChildCount < baseOffset) {
                    void(0);
                    baseOffset = baseChildCount;
                }
                if (extentChildCount < extentOffset) {
                    void(0);
                    extentOffset = extentChildCount;
                }
                if (curSel.isCollapsed) {
                    void(0);
                    sel.setPosition(extentNode, extentOffset);
                } else {
                    void(0);
                    sel.setBaseAndExtent(baseNode, baseOffset, extentNode, extentOffset);
                }
            }
        }
    } catch (e) {
        void(0);
        void(0);
    } finally {
       
    }
};

QMail.Editor.prototype.resetStoredSelection = function resetStoredSelection() {
    this._currentSelection = null;
    this._currentNode = null;
    this._currentOffset = null;
};

QMail.Editor.prototype.setSelectionAtEnd = function setSelectionAtEnd(root) {
    void(0);
    QMail.Debug.log('setSelectionAtEnd');
    root = root ? root : this._rootElement;
    var childCount = root.childNodes.length;
    var sel = window.getSelection();
    sel.setBaseAndExtent(root, childCount, root, childCount);
};

QMail.Editor.prototype.getInnerHtml = function() {
    this.trigger('beforeGetHtml');
    var html = this._rootElement.innerHTML;
    this.trigger('afterGetHtml');
    return html;
}

QMail.Editor.prototype.hasChanges = function hasChanges() {
    var currentHtml = this.getInnerHtml();
    var isDiffs = QMail.Diffs.shareInstance.isDiffsWithText(currentHtml);
    return isDiffs;
};

QMail.Editor.prototype.setInnerHtml = function(html) {
    this._rootElement.innerHTML = html;
}

QMail.Editor.prototype.getTextHeight = function() {
    // ipad下QMail.Viewer.viewport.scale，竖屏是1，横屏是0.75，导致横屏计算错误。所以这里不乘QMail.Viewer.viewport.scale了
    return Math.floor(this._rootElement.scrollHeight);
}

QMail.Editor.prototype.getTextWidth = function() {
    return Math.floor(this._rootElement.scrollWidth);
}

QMail.Events.mixTo(QMail.Editor);

})();