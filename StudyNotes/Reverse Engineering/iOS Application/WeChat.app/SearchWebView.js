// We're using a global variable to store the number of occurrences
var MyApp_SearchResultCount = 0;
var MyApp_SearchKeywordNum = 0;
var MyApp_SearchClickTime = 0;
var MyApp_SearchKeywordBox = new Array();

// helper function, recursively searches in elements and their child nodes
function MyApp_HighlightAllOccurencesOfStringForElement(element,keyword) {
  if (element) {
    if (element.nodeType == 3) {        // Text node
        var results = new Array();
        while (true) {
            var value = element.nodeValue;  // Search for keyword in text node
            var idx = value.toLowerCase().indexOf(keyword);

            if (idx < 0) break;             // not found, abort
 
            var span = document.createElement("span");
            var text = document.createTextNode(value.substr(idx,keyword.length));
            span.appendChild(text);
            span.setAttribute("class","MyAppHighlight");
            span.style.backgroundColor="rgba(155, 155, 155, 0.5)";//"#9B9B9B"
            //span.style.color="black";
            text = document.createTextNode(value.substr(idx+keyword.length));
            element.deleteData(idx, value.length - idx);
            var next = element.nextSibling;
            element.parentNode.insertBefore(span, next);
            element.parentNode.insertBefore(text, next);
            element = text;
          
            //防止一些空节点，但是会造成一部分误计算，不会漏过高亮
            //if(span.offsetTop == 0) {
            //    return;
            //}
            
            results.push(span);
            MyApp_SearchResultCount++;	// update the counter
        }
        
        //save,按实际正顺序
        for (var i=results.length-1; i>=0; i--) {
            var result = results[i];
            MyApp_SearchKeywordBox.push(result);
        }
    }
    else if (element.nodeType == 1) { // Element node
        if (element.style.display != "none" && element.nodeName.toLowerCase() != 'select') {
            for (var i=element.childNodes.length-1; i>=0; i--) {
                var elementTagName = element.childNodes[i].tagName;
                if(elementTagName !== "SCRIPT" && elementTagName !== "STYLE")
                {
                    MyApp_HighlightAllOccurencesOfStringForElement(element.childNodes[i],keyword);
                }
            }
        }
    }
  }
}

function scrollToPositionWithDuration(left, top) {
    if (top < 0) {
        top = 0; //必须，否则会死循环
    }
    
    var relScrollStep = 0;
    var startY = window.scrollY;
    
    var scrollDuration = 100;
    var scrollHeight = Math.abs(top - startY)
    if (scrollHeight < 100)
    {
        scrollDuration = 60;
    }else if (scrollHeight < 500) {
        scrollDuration = scrollHeight / 4;
    }else if (scrollHeight < 1000) {
        scrollDuration = scrollHeight / 8;
    }else {
        scrollDuration = 200;
    }

    if (startY > top) {
        //move top
        relScrollStep = -(startY - top) / ((scrollDuration+15) / 15);
    }else {
        //move bottom
        relScrollStep = (top - startY) / ((scrollDuration+15) / 15);
    }
    
    //console.log("\nkkk scrollY:"+window.scrollY+" scrollBy:"+relScrollStep+" top:"+top);
    //保证不会陷入死循环
    if (Math.abs(relScrollStep) < 2){
        scrollTo(left,top);
        return;
    }

    var loopCount = 0; //保证不陷入死循环
    var scrollInterval = setInterval(function() {
                                 if ( (((relScrollStep > 0 && window.scrollY < top) || (relScrollStep < 0 && window.scrollY > top)) && loopCount < 10 &&
                                       (window.scrollY > 0) && (Math.abs(window.scrollY - top) > relScrollStep)) ) {
                                     //console.log("\nscrollY:"+window.scrollY+" scrollBy:"+relScrollStep+" top:"+top);
                                     window.scrollBy( left, relScrollStep );
                                     loopCount++;
                                 }
                                 else {
                                     //console.log("\nclear timer");
                                     clearInterval(scrollInterval);
                                     scrollTo(left,top);
                                     loopCount = 0;
                                 }
                                 },15);
}


function getPosition(e, bIsdirectScrollTo) {
    e.style.backgroundColor="rgba(26, 173, 25, 0.6)";//"#1AAD19"
    var t = e.offsetTop;
    var l = e.offsetLeft;
    var w = e.offsetWidth;
    var h = e.offsetHeight-1;
    while(e=e.offsetParent) {
        t+=e.offsetTop;
        l+=e.offsetLeft;
    }
    
    if (bIsdirectScrollTo) {
        scrollTo(l,t-70);
    }else {
        scrollToPositionWithDuration(l, t-70);
    }
}

// the main entry point to start the search
function MyApp_HighlightAllOccurencesOfString(keyword, index) {
    MyApp_RemoveAllHighlights();
    MyApp_SearchClickTime = parseInt(index);
    MyApp_SearchKeywordNum = 0;
    MyApp_SearchKeywordBox = new Array();
    MyApp_HighlightAllOccurencesOfStringForElement(document.body, keyword.toLowerCase());
    var arrLength = MyApp_SearchKeywordBox.length;
    if(index > 0 && index <= arrLength) {
        var bIsdirectScrollTo = false;
        if (index === 1 || index === arrLength) {
            bIsdirectScrollTo = true;
        }
        getPosition(MyApp_SearchKeywordBox[arrLength-index], bIsdirectScrollTo);
    }

    return arrLength;
}

// helper function, recursively removes the highlights in elements and their childs
function MyApp_RemoveAllHighlightsForElement(element) {
  if (element) {
    if (element.nodeType == 1) {
      if (element.getAttribute("class") == "MyAppHighlight") {
        var text = element.removeChild(element.firstChild);
        element.parentNode.insertBefore(text,element);
        element.parentNode.removeChild(element);
        return true;
      } else {
        var normalize = false;
        for (var i=element.childNodes.length-1; i>=0; i--) {
          if (MyApp_RemoveAllHighlightsForElement(element.childNodes[i])) {
            normalize = true;
          }
        }
        if (normalize) {
          element.normalize();
        }
      }
    }
  }
  return false;
}

// the main entry point to remove the highlights
function MyApp_RemoveAllHighlights() {
  MyApp_SearchResultCount = 0;
  MyApp_RemoveAllHighlightsForElement(document.body);
}

