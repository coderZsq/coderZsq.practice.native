var domain_list = {};

function getDomain(els, attr){
	if (!els || els.length <= 0)
		return;

	var el, attrv, matchs;
	var reg = /http(s)?\:\/\/([^\/]*)(\?|\/)?/;
	for (var i = 0, len = els.length; i < len; ++i){
		el = els[i];
		if (!el) {
			continue;
		}
		attrv = el.getAttribute(attr);
        domain_list[attrv] = true;
//		if (!!attrv){
//			matchs = attrv.match(reg);
//			if (!!matchs&&!!matchs[2]){
//				domain_list[matchs[2]] = true;
//			}
//		}
	}
}

function getDomainList(){
	domain_list = {};
	//link href
	//a href
	getDomain(document.getElementsByTagName("a"), 'href');
	getDomain(document.getElementsByTagName("link"), 'href');

	//iframe src
	//script src
	//img src
	getDomain(document.getElementsByTagName("iframe"), 'src');
	getDomain(document.getElementsByTagName("script"), 'src');
	getDomain(document.getElementsByTagName("img"), 'src');

	var ret = [];

	for (var k in domain_list){
		if (domain_list.hasOwnProperty(k)){
			ret.push(k);
		}
	}
	domain_list = {};
	return ret.join(",");
}

var domain_list_ret = getDomainList();//最后的那个数组



//------------
var total_html, content_length;

(function(){
	total_html = document.getElementsByTagName("html");
	if (!!total_html && !!total_html.length == 1){
		total_html = total_html[0].innerHTML;
		//去除ascii 得到其他字符
		var no_ascii = total_html.replace(/[\x00-\xff]/g, '');

		//去除非ascii
		var ascii = total_html.replace(/[^\x00-\xff]/g, '');

		content_length = ascii.length*1 + no_ascii.length*3 + "<!DOCTYPE html><html></html>".length;
	}
})();