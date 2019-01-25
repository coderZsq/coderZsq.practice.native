/**
 * created : flyhuang
 *  客户端需要先比对html的差异再提交数据节省流量
 *  但是有时候客户端需要针对某些标签加上一些属性和样式会导致html的变化从而导致频繁提交
 *  而如果只判断用户键盘有操作也会导致不必要的提交，ios系统和evernote是这样做的
 *  如果只比较innerText的话又会导致丢失img和audio的变化从而少了提交
 *  所以需要有针对性的进行比较，只比较去除标签属性后的变化
 */

QMail.Diffs = function() {
	this.init();
}

QMail.Diffs.getShareInstance = (function() {

	var _instance = null;

	return function(){

		if(!_instance) {
			_instance = new QMail.Diffs();
		}

		return _instance;
	};
})();

QMail.Diffs.__defineGetter__("shareInstance", QMail.Diffs.getShareInstance);

QMail.Diffs.prototype.init = function() {
	this._originalText = '';
}

QMail.Diffs.prototype.saveCurrentText = function() {

	var html = QMail.evaluator.getHtml();
	this._originalText = this.igoresElementTagWithText(html);
}

QMail.Diffs.prototype.igoresElementTagWithText = function(text) {

	if(text) {
		var currentPrefix = [];
		var result = [];


		for (var i = 0; i < text.length; i++) {
			var currentChar = text.charAt(i);

			if(currentChar == '<') {
				currentPrefix.push(currentChar);
				if(currentPrefix.length == 1) {
					result.push(currentChar);
				} 
			} else if(currentChar == '>') {
				if(currentPrefix.length > 0) {
					currentPrefix.pop();
					if(currentPrefix.length <= 0) {
						result.push(currentChar);
					}
				} else {
					result.push(currentChar);
				}
			} else {
				if(currentPrefix.length <= 0) {
					result.push(currentChar);
				}
			}
		};
		return result.join('');
	} else {
		return "";
	}
}

QMail.Diffs.prototype.isDiffsWithText = function(currentText) {

	var currentText = this.igoresElementTagWithText(currentText);
	return currentText != this._originalText;
}

