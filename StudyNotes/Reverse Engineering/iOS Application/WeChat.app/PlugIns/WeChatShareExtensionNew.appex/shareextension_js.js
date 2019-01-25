var MMExtensionClass = function() {};

MMExtensionClass.prototype = {
run: function(arguments)
    {
        if(!document.body)
        {
            arguments.completionFunction({"title": document.title,
                                         "url": document.URL});
            return;
        }
        
        
        //获取苹果safari icon
        var linkTag = document.getElementsByTagName("link");
        var iconSource;
        
        for(var i = 0; i < linkTag.length; i++) {
            if(linkTag[i].rel == "apple-touch-icon-precomposed" || linkTag[i].rel == "apple-touch-icon") {
                iconSource = linkTag[i].href;
                break;
            }
        }
        
        //获取facebook的og:image，详见：
        //https://developers.facebook.com/docs/opengraph/using-objects?locale=zh_CN
        if(!iconSource) {
            var metas = document.getElementsByTagName("meta");
            for (var i = 0; i < metas.length; ++i) {
                var meta = metas[i];
                if (meta.attributes["property"] != undefined && meta.attributes["property"].value === "og:image" && meta.attributes["content"] != undefined) {
                    iconSource = meta.attributes["content"].value;
                }
            }
        }
        
        if(iconSource)
        {
            arguments.completionFunction({"title": document.title,
                                         "image":  iconSource,
                                         "url": document.URL});
            return;
        }
        
        var _allImgs = document.body.getElementsByTagName('img');
        
        if(_allImgs.length == 0)
        {
            arguments.completionFunction({"title": document.title,
                                         "url": document.URL});
            return;
        }
        
        // 过滤掉重复的图片
        var _srcs = {};
        var allImgs = [];
        for (var i = 0; i < _allImgs.length; i++) {
            var _img = _allImgs[i];
            
            // 过滤掉不可以见的图片
            if (_img.style.display == 'none' || _img.style.visibility == 'hidden'){
                continue;
            }
            
            if (_srcs[_img.src]) {
                // added
            } else {
                _srcs[_img.src] = 1; // mark added
                allImgs.push(_img);
            }
        }
        
        var max_area = 0;
        var index = 0;
        
        for (var i = 0; i < allImgs.length && i < 100; i++)
        {
            img = allImgs[i];
            
            var newImage = new Image();
            newImage.src = img.src;
            
            var area = newImage.width * newImage.height;
            if ( area > max_area)
            {
                max_area = area;
                index = i;
            }
        }
        
        if(allImgs[index].src) {
            
            arguments.completionFunction({"title": document.title,
                                         "image":  allImgs[index].src,
                                         "url": document.URL});
            return;
        }
    }
};

var ExtensionPreprocessingJS = new MMExtensionClass;