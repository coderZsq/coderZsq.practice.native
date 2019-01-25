/**
 * created by flyhuang 
 *
 * @issue 1 : 提供对比内容差异的方案
 * @issue 2 : 光标问题wired的处理
 * @issue 3 : 调试信息面板 
 * @issue 4 : 设置font-size 后scroll值是按照缩放比例的
 * @issue 5 : 编辑状态缩放后的光标
 * @issue 6 : contenteditable嵌套在首行无法定位光标删除
 * @issue 7 : contenteditable嵌套在末行无法定位光标
 * @issue 8 : contenteditable嵌套一删除删除多个
 * @issue 9 : 编辑态滚动条过长
 * @issue 10: 在底部编辑的跳动问题
 *
 * @todo 1 : 插入图片或者语音光标自动定位到下一行
 * @todo 2 : 提供调试输出面板
 */
QMail.Viewer = function(options) {

    this.opts = QMail.Util.extend({
        rootElement : null
    },options);

    this.init();
}

QMail.Viewer.getInstance = function() {
    if (!this._instance) {
        this._instance = new QMail.Viewer({
            rootElement : document.getElementById(QMail.config.editorId)
        });
    }
    return this._instance;
}

QMail.Viewer.getViewport = function() {

    if(!this._viewport) {
        var ViewPort = QMail.Viewport;
        this._viewport = new ViewPort();
    }

    return this._viewport;
}


QMail.Viewer.__defineGetter__("instance", QMail.Viewer.getInstance);
QMail.Viewer.__defineGetter__("viewport", QMail.Viewer.getViewport);

QMail.Viewer.prototype._imagePreloader = null;
QMail.Viewer.prototype._rootElement = null;
QMail.Viewer.prototype._editor = null;
QMail.Viewer.prototype._isReady = null;
QMail.Viewer.prototype.init = function init() {

    this._rootElement = this.opts.rootElement;

    this.__defineGetter__("rootElement", this.getRootElement);
    this.__defineGetter__("editor", this.getEditor);
    this.__defineGetter__("lastTouchElement", this.getLastTouchElement);
    this.__defineGetter__("imagePreloader", this.getImagePreloader);
    this.__defineGetter__("showImageLoading", this.getShowImageLoading);
    //设置图片的预处理状态
    this.__defineSetter__("showImageLoading", this.setShowImageLoading);
};

QMail.Viewer.prototype.getRootElement = function getRootElement() {
    if (!this._rootElement) {
        this._rootElement = document.body;
    }
    return this._rootElement;
};

QMail.Viewer.prototype.getEditor = function() {

    if(!this._editor) {
        this._editor = new QMail.Editor({
            rootElement    : this.opts.rootElement
        });

        this._editor.on('beforeGetHtml' , this._onbeforeGetHtml , this);
        this._editor.on('afterGetHtml' , this._onafterGetHtml , this);
    }

    return this._editor;
}

QMail.Viewer.prototype.ready = function() {

    if(this._isReady) {
        return;
    }

    this._bindEvents();
    this._isReady = true;
}

QMail.Viewer.prototype._bindEvents = function() {
    this.rootElement.addTapEventListener(this._onTapEnd , false);
    this.rootElement.addLongPressEventListener(this._onLongPressed, false);
    document.body.addTapEventListener(this._onTapBody, false);
}

QMail.Viewer.prototype._unbindEvents = function() {
    this.rootElement.removeTapEventListener(this._onTapEnd);
    tdocument.body.removeTapEventListener(this._onTapBody);
}

QMail.Viewer.prototype._onLongPressed = function(e) {

    if(e.target.nodeName.toLocaleLowerCase() == 'img') {
        //用户在非编辑态度长按图片
        QMail.NativeNotifier.notify('longPressImageFromJs' , {
            filePath : e.target.getAttribute('src')
        });
    }
}

QMail.Viewer.prototype._onTapEnd = function(e) {

    var self = QMail.Viewer.instance;

    if(self.editor.shouldEnterFocusWhenTap(e)) {
        //编辑的入口通过tapEnd去统一控制
        self.storeLastTouchElement(e);
        self.startEdit();
    }
}

QMail.Viewer.prototype.storeLastTouchElement = function(e) {

    this._lastTouchElement = e.target;
}

QMail.Viewer.prototype.getLastTouchElement = function(e) {

    return this._lastTouchElement;
}

QMail.Viewer.prototype.clearLastTouchElement = function() {

    this._lastTouchElement = null;
}

QMail.Viewer.prototype.startEdit = function() {
    this.rootElement.setAttribute("contenteditable", true);
    this.editor.startEdit();
}

QMail.Viewer.prototype.restoreStart = function() {
    this.startEdit();
    this.editor.focus();
    this.editor.restoreSelection();
}

QMail.Viewer.prototype.stopEdit = function() {
    this.rootElement.setAttribute("contenteditable", false);
    this.editor.stopEdit();
}

QMail.Viewer.prototype.getImagePreloader = function() {

    if(!this._imagePreloader) {
        this._imagePreloader = new QMail.ImgPreloader();
    }

    return this._imagePreloader;
}

//提前加载图片
QMail.Viewer.prototype.setShowImageLoading = function(show) {

    if(show) {
        this.imagePreloader.start(this._handlePreloadImages);
    } else {
        this.imagePreloader.restore();
    }
    this._showImageLoading = show;
}

QMail.Viewer.prototype._handlePreloadImages = function() {
    //加载完成后缩放页面
    setTimeout(function(){
        if(QMail.Viewer.viewport.shouldScaleToFix) {
            QMail.Viewer.viewport.scaleToFix();
        }
    },100);
}

QMail.Viewer.prototype.getShowImageLoading = function() {
    return this._showImageLoading;
}

QMail.Viewer.prototype._onTapBody = function(e){

    if(e.target == document.body) {
        QMail.Debug.log('_onTapBody');
        var self = QMail.Viewer.instance;
        self._focus();
        if(QMail.config.tapBodyToEnd) {
            self.editor.setSelectionAtEnd();       
        }
    }
}

QMail.Viewer.prototype._focus = function(){
    var self = QMail.Viewer.instance;
    if(!self.editor.isFocus) {
        self.clearLastTouchElement();
        self.startEdit();
        self.rootElement.focus();
    } 
}

QMail.Viewer.prototype._onbeforeGetHtml = function() {

    this.showImageLoading && this.imagePreloader.restore();

    QMail.Debug.log('_onbeforeGetHtml');
}

QMail.Viewer.prototype._onafterGetHtml = function() {

    this.showImageLoading && this.imagePreloader.start(this._handlePreloadImages);
    QMail.Debug.log('_onafterGetHtml');
}

QMail.Events.mixTo(QMail.Viewer);




