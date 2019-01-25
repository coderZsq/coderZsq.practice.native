/**
 * created by flyhuang 
 * 负责实现图片加载的loading的效果
 */
 
(function(){

var ImgLoadEnum = {
    initial  : 0 , //初始状态 
    waiting  : 1 , //已经发起请求
    success  : 2 , //请求完毕成功
    fail     : 3   //请求完毕失败
}

document.addEventListener('DOMContentLoaded', function () {
    //预加载本地的loading图片让浏览器cache
    var img = new Image();
    img.src = 'filetype_placeholder_image_h80.png';
});

QMail.ImgPreloader = function() {

    //记录当前已经load完毕的图片，key 为src
    this._loadedImagesStatus = {};
    //获取当前所有图片的loading状态
    this.__defineGetter__("preloadImages", this.getPreloadImages);

}

QMail.ImgPreloader.prototype._loadingShowDelay = 10;
QMail.ImgPreloader.prototype._done = false;
QMail.ImgPreloader.prototype._started = false;
QMail.ImgPreloader.prototype._loadedImagesMap = null;
QMail.ImgPreloader.prototype._preloadImages = null;
QMail.ImgPreloader.prototype.PRE_LOADER_CLASS = 'qm-preloader';

QMail.ImgPreloader.prototype.getPreloadImages = function() {

    if(!this._preloadImages) {
        this._preloadImages = {};
        var imgs = document.getElementsByTagName('img');

        for (var i = 0; i < imgs.length; i++) {
            var imgObject = this._createImgObject(imgs[i]);
            var imgArr = this._preloadImages[imgObject.oriSrc];

            if(!imgArr) {
                imgArr = [imgObject];
                this._preloadImages[imgObject.oriSrc] = imgArr;
            } else {
                imgArr.push(imgObject);
            }
        }
    }

    return this._preloadImages;
} 

QMail.ImgPreloader.prototype._createImgObject = function(img) {

    return {
        img              : img,
        oriSrc           : img.getAttribute('src'),
        hasClassAttibute : img.hasAttribute('class')
    }
}

QMail.ImgPreloader.prototype._isImageLoaded = function(imgObject) {

    return this._loadedImagesMap[imgObject.oriSrc];
}

QMail.ImgPreloader.prototype._getImagesArrWithUrl = function(url) {

    var imgArr = this.preloadImages;
    return imgArr[url] || [];
}

QMail.ImgPreloader.prototype._loadingImagesWithUrl = function(url) {

    var loadingStatus = this._loadedImagesStatus[url];
    var self = this;

    //判断当前加载请求状态
    if(!loadingStatus) {
        loadingStatus = {
            status : ImgLoadEnum.initial 
        }
        this._loadedImagesStatus[url] = loadingStatus;
    }

    if(loadingStatus.status == ImgLoadEnum.initial) {

        this._requsetImage(url , function() {

            self._successLoadImagesWithUrl(url);
            
        } , function() {
            self._failLoadImagesWithUrl(url);
        });

        //等待状态要将图片样式设置为loading
        this._setImagesWaitingWithUrl(url);

    } else if(loadingStatus.status == ImgLoadEnum.waiting) {
        //等待状态要将图片样式设置为loading
        this._setImagesWaitingWithUrl(url);

    } else if(loadingStatus.status == ImgLoadEnum.success) {

        this._successLoadImagesWithUrl(url);

    } else if(loadingStatus.status == ImgLoadEnum.fail) {

        this._failLoadImagesWithUrl(url);
    }
}

QMail.ImgPreloader.prototype._setImagesWaitingWithUrl = function(url) {

    var self = this;
    var loadingStatus = this._loadedImagesStatus[url];

    //延迟一段时间再修改为loading的样式，因为有缓存的情况下onload会很快导致出现 
    //loaded - loading - loaded 
    //loaded 
    // sleep loading loaded

    if(loadingStatus.status == ImgLoadEnum.waiting) {

        if(this._loadingShowDelay == 0) {
            self._setImagesLoadingWithUrl(url);
        } else {
            setTimeout(function(){
                self._setImagesLoadingWithUrl(url);
            },this._loadingShowDelay);
        }
    }
    
}

QMail.ImgPreloader.prototype._successLoadImagesWithUrl = function(url) {

    this._restoreImagesLoadingWithUrl(url);
    this._doneImagesWithUrl(url);
}

QMail.ImgPreloader.prototype._failLoadImagesWithUrl = function(url) {
    
    this._restoreImagesLoadingWithUrl(url);
    this._doneImagesWithUrl(url);
}

QMail.ImgPreloader.prototype._doneImagesWithUrl = function(url) {
    var preloadImages = this.preloadImages;
    delete preloadImages[url] ;

    var count = 0;

    for (var key in preloadImages) {
        count++;
    };

    if(count == 0) {
        this._done = true;

        if(this.doneCallback) {
            this.doneCallback && this.doneCallback(url);
        }
    }
}

QMail.ImgPreloader.prototype._setImagesLoadingWithUrl = function(url) {

    var imgArr = this._getImagesArrWithUrl(url);

    for (var i = 0; i < imgArr.length; i++) {
        var imgObject = imgArr[i];
        this._setImageLoading(imgObject);
    };
}

QMail.ImgPreloader.prototype._restoreImagesLoadingWithUrl = function(url) {

    var imgArr = this._getImagesArrWithUrl(url);

    for (var i = 0; i < imgArr.length; i++) {
        var imgObject = imgArr[i];
        this._restoreImageLoading(imgObject);
    };
}

//此处修改为loading时的样式
QMail.ImgPreloader.prototype._setImageLoading = function(imgObject) {

    var imgElm = imgObject.img;
    imgElm.addClass(this.PRE_LOADER_CLASS);
    // imgElm.src = 'about:blank';
}

//此处修改为原来的样式
QMail.ImgPreloader.prototype._restoreImageLoading = function(imgObject) {

    var imgElm = imgObject.img;
    imgElm.removeClass(this.PRE_LOADER_CLASS);

    if(imgElm.src != imgObject.oriSrc && imgObject.oriSrc) {
        imgElm.src = imgObject.oriSrc;
    }
    if(!imgObject.hasClassAttibute) {
        imgElm.removeAttribute('class');
    }
}

//加载请求
QMail.ImgPreloader.prototype._requsetImage = function(src , succCallback , failCallback) {

    var loadingStatus = this._loadedImagesStatus[src];

    if(loadingStatus.status == ImgLoadEnum.initial) {

        var imgArr = this._preloadImages[src];
        var img = new Image();

        loadingStatus.status = ImgLoadEnum.waiting;

        img.onload = function() {

            // setTimeout(function(){
                loadingStatus.status = ImgLoadEnum.success;
                succCallback && succCallback(src);
            // },2000);   
            img.onload = null;
            img.onerror = null;
        }

        img.onerror = function() {
            loadingStatus.status = ImgLoadEnum.fail;
            failCallback && failCallback(src);
            img.onload = null;
            img.onerror = null;
        }

        img.src = src;
    }
}

QMail.ImgPreloader.prototype.start = function(doneCallback) {

    this.doneCallback = doneCallback;

    if(!this._done) {
        var preloadImages = this.preloadImages;
        for (var url in preloadImages) {
            this._loadingImagesWithUrl(url);  
        };
    }
}

QMail.ImgPreloader.prototype.restore = function() {

    if(!this._done) {
        var preloadImages = this.preloadImages;
        
        for (var url in preloadImages) {
            this._restoreImagesLoadingWithUrl(url);  
        };
    }
}

})();