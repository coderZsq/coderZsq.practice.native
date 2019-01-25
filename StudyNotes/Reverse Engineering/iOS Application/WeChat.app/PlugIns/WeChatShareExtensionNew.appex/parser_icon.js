
(function() {

	urlShareSource = new Object();
 	
 	var iconSource;
 	var titleSource;
 	var desSource;

 	var linkTag = document.getElementsByTagName("link");

	for(var i = 0; i < linkTag.length; i++) {
    	if(linkTag[i].rel == "apple-touch-icon-precomposed" || linkTag[i].rel == "apple-touch-icon") {
        	iconSource = linkTag[i].href;
        	break;
    	}
	}

	if(!iconSource) {
	    var metas = document.getElementsByTagName("meta");
	    for (var i = 0; i < metas.length; ++i) {
	        var meta = metas[i];
	        if (meta.attributes["property"] != undefined && meta.attributes["property"].value === "og:image" && meta.attributes["content"] != undefined) {
	            iconSource = meta.attributes["content"].value;
	        }

	        if (meta.attributes["property"] != undefined && meta.attributes["property"].value === "og:title" && meta.attributes["content"] != undefined) {
	            titleSource = meta.attributes["content"].value;
	        }

	        if (meta.attributes["property"] != undefined && meta.attributes["property"].value === "og:description" && meta.attributes["content"] != undefined) {
	            desSource = meta.attributes["content"].value;
	        }
	    }
	}

	if (!titleSource) {
		
		titleSource = document.title;
	}

	if (!desSource) {
		
		desSource = document.URL;
	}

	if (!iconSource) {

		var _allImgs = document.body.getElementsByTagName('img');

		if(_allImgs.length > 0)
		{
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

			for (var i = 0; i < allImgs.length && i < 30; i++){
			    
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

			if(allImgs[index].src){
				iconSource = allImgs[index].src;
			}
		}
	}


	if (desSource) {
		urlShareSource.desSource = desSource;
	}

	if (titleSource) {
		urlShareSource.titleSource = titleSource;
	}

	if (iconSource) {
		urlShareSource.iconSource = iconSource;
	}

	console.log(urlShareSource);

	return JSON.stringify(urlShareSource);

 })();