/**
 * created by flyhuang 
 * 负责实现html自动缩放的逻辑，设置页面的viewport
 */
QMail.Viewport = function() {
    this.init();
}

QMail.Viewport.prototype._shouldScaleToFix = false;
QMail.Viewport.prototype.QM_DEFAULT_MIN_SCALE = 0.001;
QMail.Viewport.prototype.QM_DEFAULT_MAX_SCALE = 2.0;

QMail.Viewport.prototype.init = function() {
    this.__defineGetter__("isLandscape", this.getIsLandscape);
    this.__defineGetter__("needScale"  , this.getNeedScale);
    this.__defineGetter__("scale"  , this.getScale);
    this.__defineGetter__("screenWidth"  , this.getScreenWidth);
    this.__defineGetter__("shouldScaleToFix"  , this.getShouldScaleToFix);
    this.__defineSetter__("shouldScaleToFix"  , this.setShouldScaleToFix);
}

QMail.Viewport.prototype.getScreenWidth = function() {
    return this.isLandscape ? 480 : 320;
}

QMail.Viewport.prototype.getNeedScale = function() {
    
    return document.body.scrollWidth > this.screenWidth;
}

QMail.Viewport.prototype.getIsLandscape = function() {
    return window.isLandscape;
}

QMail.Viewport.prototype.setViewPortContent = function(initialScale , minScale, maxScale , userScaleable) {

    var scalble = userScaleable ? 'yes' : 'no';
    var viewport = this.getViewPortElement();

    viewport.setAttribute('content' ,  "initial-scale=" + initialScale + ", " + 
                                       "user-scalable=" + scalble + ", " + 
                                       "maximum-scale=" + maxScale + "," + 
                                       "minimum-scale=" + minScale);
}

QMail.Viewport.prototype.getViewPortElement = function() {
    return document.querySelector("meta[name=viewport]");
}


QMail.Viewport.prototype.getAllImgElements = function() {
    return document.getElementsByTagName("img");
}

QMail.Viewport.prototype.adjustImgsToFix = function(imgs) {

    for (var i = 0; i < imgs.length; i ++) {
        var width  = imgs[i].style.width  || imgs[i].width;
        var height = imgs[i].style.height || imgs[i].height;
        this.adjustImg(imgs[i] , width , height);
    }
}

QMail.Viewport.prototype.adjustImg = function(img , width, height) {
    var imageMaxWidth = this.isLandscape ? QMail.config.fixImgMaxWidthLandspace : QMail.config.fixImgMaxWidth;
    if(width > 0 && height > 0) {
        imageMaxWidth = imageMaxWidth > width ? width : imageMaxWidth;
        var imageMaxHeight = imageMaxWidth * height / width;
        img.style.width = imageMaxWidth + "px";
        img.style.height = imageMaxHeight + "px";
    } else {
        img.style.maxWidth = imageMaxWidth + "px";
    }
}

QMail.Viewport.prototype._doScale = function(){
    var screenWidth = this.screenWidth;
    var newScale = screenWidth / (document.body.scrollWidth);
    QMail.Debug.log('newScale:' + newScale);
    this.trigger('beforeScaleTofix' , newScale);
    this.setViewPortContent(newScale , this.QM_DEFAULT_MIN_SCALE , this.QM_DEFAULT_MAX_SCALE , true);
    this._hasScale = true;
}

QMail.Viewport.prototype.getScale = function() {
    return screen.width / window.innerWidth;
}

QMail.Viewport.prototype.scaleToFix = function() {

    var self = this;
    QMail.Debug.log('scaleToFix');

    if (this.needScale) {
        
        this._doScale();

        this._clearCheck();

        this._checkScaleTimer = setInterval(function() {
             if (/loaded|complete|interactive/.test(document.readyState)) {
                if(self.shouldScaleToFix) {
                    self._doScale();
                } else {
                    self.disableUserScale();
                }
                self._clearCheck();
             }
        }, 20);

        window.onload = function() {
            if(self.shouldScaleToFix) {
                self._doScale();
            } else {
                self.disableUserScale();
            }
        }
    } else {
        self.disableUserScale();
    }
}

QMail.Viewport.prototype.disableUserScale = function() {
    this.setViewPortContent(1.0 , this.QM_DEFAULT_MIN_SCALE , this.QM_DEFAULT_MAX_SCALE , false);
}

QMail.Viewport.prototype._clearCheck = function(){
    if(this._checkScaleTimer) {
        clearInterval(this._checkScaleTimer);
        this._checkScaleTimer = null;
    }
}

QMail.Viewport.prototype.getShouldScaleToFix = function() {
    return this._shouldScaleToFix;
}

QMail.Viewport.prototype.setShouldScaleToFix = function(scale) {

    this._shouldScaleToFix = scale;

    if(this._shouldScaleToFix) {
        this.scaleToFix();
    } else {
        this.disableUserScale();
        this._clearCheck();
    }
}

QMail.Events.mixTo(QMail.Viewport);