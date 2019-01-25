/**
 * created by flyhuang 
 * 基于canvasUI实现的一些显示组件，例如语音组件
 */

(function(){

var AudioStatus = {
	playing : 1,
	ending  : 2,
	loading : 3
}

//语音标签编辑器
QMail.UIAttachment = function(element , attachInfo) {
	this.init.apply(this, [].slice.apply(arguments));
}

QMail.Util.subclass(QMail.UIAttachment, QMail.UIView);

QMail.UIAttachment.prototype.getUuid = function() {
	return 'qmattach_' + new Date().getTime() + '_' + Math.floor(Math.random() * 1000);
}

QMail.UIAttachment.prototype._styleSheetNode = null;

QMail.UIAttachment.prototype.init = function(element , attachInfo) {

	if(element) {
		this.__defineGetter__("uuid", this.getUuid);
		this.__defineGetter__("styleSheetNode", this.getStyleSheetNode);

		this.element    = element;
		this.attachInfo = attachInfo;
		QMail.UIAttachment.__super__.init.apply(this , [].slice.apply(arguments));

		var uuid = this.uuid;
		this.attachId = uuid;
		this.element.setAttachId(uuid);

		//绑定点击事件
		this.bindEvents();
	} else {
		QMail.Debug.err('missing element on create UIAudioAttachment');
	}
}

QMail.UIAttachment.prototype.bindEvents = function() {
	var self = this;
	this.element.onclick = function() {
		self.onclick && self.onclick();
	}
}

QMail.UIAttachment.prototype.destroy = function() {

	if(this.element) {
		this.element.onclick = null;
	}
	this.element = null;
	this._styleSheetNode && this._styleSheetNode.remove();
	this._styleSheetNode = null;
	QMail.UIAttachment.__super__.destroy.apply(this , [].slice.apply(arguments));
}

QMail.UIAttachment.prototype.getStyleSheetNode = function() {

	if(!this._styleSheetNode) {
		var head      = document.getElementsByTagName('head')[0],
	    	styleNode = document.createElement('style');
	    styleNode.type = 'text/css';
    	head.appendChild(styleNode);
	    this._styleSheetNode = styleNode;
	} 

	return this._styleSheetNode;
}

QMail.UIAttachment.prototype.renderToElement = function(element) {

	try {
		var canvas    = QMail.UIManager.shareInstance.canvas;
		var imageData = this.makeImageData();
		var css       = '.' + this.attachId + ' { background-image:url(' + imageData + '); }';
		var styleNode = this.styleSheetNode;

	    if (styleNode.styleSheet){
		  styleNode.styleSheet.cssText = css;
		} else {
		  styleNode.removeAllChilds();
		  styleNode.appendChild(document.createTextNode(css));
		}
		element.addClass(this.attachId);
		element.setAttribute("role", "button");
		element.style["width"] = canvas.style["width"];
		element.style["height"] = canvas.style["height"];
		element.style["background-color"] = "white";
		element.style["background-position"] = "0 0";
		element.style["background-repeat"] = "no-repeat";
		element.style["background-size"] = "cover";
	} catch(e) {
		QMail.Debug.err('renderToElement error:' + e.message);
	}
};

////////////////////////////////////////////////////////////////////
//语音标签编辑器
QMail.UIAudioAttachment = function(element , attachInfo) {
	this.init.apply(this, [].slice.apply(arguments));
}

QMail.Util.subclass(QMail.UIAudioAttachment, QMail.UIAttachment);

QMail.UIAudioAttachment.prototype.playEndImageUrl      = 'icon_recorder_end.png';
QMail.UIAudioAttachment.prototype.playIngImageUrl      = 'icon_recorder_playing.png';
QMail.UIAudioAttachment.prototype.playLoadingImageUrl  = 'icon_recorder_loading@2x.gif';

QMail.UIManager.shareInstance.registerImages(QMail.UIAudioAttachment.prototype.playEndImageUrl);
QMail.UIManager.shareInstance.registerImages(QMail.UIAudioAttachment.prototype.playIngImageUrl);
QMail.UIManager.shareInstance.registerImages(QMail.UIAudioAttachment.prototype.playLoadingImageUrl);

QMail.UIAudioAttachment.prototype.DEFAULT_WIDTH    = 276;
QMail.UIAudioAttachment.prototype.DEFAULT_HEIGHT   = 60;
QMail.UIAudioAttachment.prototype._fileSize        = '';
QMail.UIAudioAttachment.prototype._fileName        = '';
QMail.UIAudioAttachment.prototype.status           = AudioStatus.ending;   

QMail.UIAudioAttachment.prototype.filenameContextAttributes = {
	font: "bold 16px Helvetica",
	fillStyle: "#5f5f5f",
	textAlign: "left",
	textBaseline: "top"
}

QMail.UIAudioAttachment.prototype.filenamePlayingContextAttributes = {
	font: "bold 16px Helvetica",
	fillStyle: "#a4a4a4",
	textAlign: "left",
	textBaseline: "top"
}

QMail.UIAudioAttachment.prototype.filesizeContextAttributes = {
	font: "bold 13px Helvetica",
	fillStyle: "#5e5e5e",
	textAlign: "left",
	textBaseline: "top"
}

QMail.UIAudioAttachment.prototype.filesizePlayingContextAttributes = {
	font: "bold 13px Helvetica",
	fillStyle: "#b2b2b2",
	textAlign: "left",
	textBaseline: "top"
}

QMail.UIAudioAttachment.prototype.playingGradientColorTop = {
	begin : '#f3f3f3',
	end   : '#f7f7f7'
}

QMail.UIAudioAttachment.prototype.endGradientColorTop = {
	begin : '#EFEFEF',
	end   : '#FFFFFF'
}

QMail.UIAudioAttachment.prototype.init = function() {
	var success = QMail.UIAudioAttachment.__super__.init.apply(this , [].slice.apply(arguments));

	this.__defineGetter__("fileSize", this.getFileSize);
	this.__defineGetter__("fileName", this.getFileName);

	this.__defineSetter__("fileSize", this.setFileSize);
	this.__defineSetter__("fileName", this.setFileName);

	this.initView();

	this.fileName = this.attachInfo.fileName;
	this.fileSize = this.attachInfo.fileSize + 'kbytes';
}

QMail.UIAudioAttachment.prototype.destroy = function() {
	QMail.UIAudioAttachment.__super__.destroy.apply(this , [].slice.apply(arguments));
}

QMail.UIAudioAttachment.prototype.getFileSize = function() {
	return this._fileSize;
}

QMail.UIAudioAttachment.prototype.setFileSize = function(fileSize) {
	this._fileSize = fileSize;
	this.labelFileSize.text = fileSize;
}

QMail.UIAudioAttachment.prototype.getFileName = function() {
	return this._fileName;
}

QMail.UIAudioAttachment.prototype.setFileName = function(fileName) {
	this._fileName = fileName;
	this.labelFileName.text = fileName;
}

QMail.UIAudioAttachment.prototype.initView = function() {

	this.frame = new Frame(0 , 0 , this.DEFAULT_WIDTH, this.DEFAULT_HEIGHT);

	var imgView     = new QMail.UIImageView();
	var imgWidth    = 30;
	var imgHeight   = 30;
	var paddingLeft = 10;
	var margingLeft = 10;
	var paddingTop  = (this.DEFAULT_HEIGHT - imgHeight) / 2;

	imgView.frame = new Frame(paddingLeft , paddingTop , imgWidth, imgHeight);
	imgView.image = new QMail.UIImage.imageNamed(this.playEndImageUrl);
	this.imgView = imgView;

	var labelFileName = new QMail.UILabel();
	var fileTextMarginTop = 5;

	var leftWidth = this.DEFAULT_WIDTH - paddingLeft * 2 - margingLeft - imgWidth;
	var fileNameHeight = 16;
	var fileSizeHeight = 13;

	var fileNameTop = this.DEFAULT_HEIGHT - (fileTextMarginTop + fileNameHeight + fileSizeHeight);
	fileNameTop = fileNameTop / 2;

    labelFileName.frame = new Frame(paddingLeft + imgWidth +  margingLeft, fileNameTop, leftWidth, fileNameHeight);
    labelFileName.text = this.fileSize;
    labelFileName.contextAttribute  = this.filenameContextAttributes;
    this.labelFileName = labelFileName;

    var labelFileSize = new QMail.UILabel();
    labelFileSize.frame = new Frame(paddingLeft + imgWidth +  margingLeft,  fileNameTop + fileNameHeight + fileTextMarginTop, leftWidth, fileSizeHeight);
    labelFileSize.text = this.fileName;
    labelFileSize.contextAttribute  = this.filesizeContextAttributes;
    this.labelFileSize = labelFileSize;

    this.addSubview(imgView);
    this.addSubview(labelFileName);
    this.addSubview(labelFileSize);
}

QMail.UIAudioAttachment.prototype.showPlaying = function() {
	if(this.element) {
		this.status = AudioStatus.playing;
		this.imgView.image = new QMail.UIImage.imageNamed(this.playIngImageUrl);
		this.labelFileSize.contextAttribute = this.filesizePlayingContextAttributes;
		this.labelFileName.contextAttribute = this.filenamePlayingContextAttributes;
		this.renderToElement(this.element);
	}
}

QMail.UIAudioAttachment.prototype.showEnding = function() {
	if(this.element) {
		this.status = AudioStatus.ending;
		this.imgView.image = new QMail.UIImage.imageNamed(this.playEndImageUrl);
		this.labelFileSize.contextAttribute = this.filesizeContextAttributes;
		this.labelFileName.contextAttribute = this.filenameContextAttributes;
		this.renderToElement(this.element);
	}
}

QMail.UIAudioAttachment.prototype.drawRect = function() {
	QMail.UIAudioAttachment.__super__.drawRect.apply(this , [].slice.apply(arguments));

	if(this._drawRect) {
		var uiManager = QMail.UIManager.shareInstance;
		uiManager.saveContext();
		var ctx = uiManager.context;
		ctx.rect(0, 0, this._drawRect.width, this._drawRect.height);
		var grd = ctx.createLinearGradient(0, this._drawRect.height, 0 , 0);
		var colorStopBeing, colorStopEnd;

		if(this.status == AudioStatus.playing || this.status == AudioStatus.loading) {
			colorStopBeing = this.playingGradientColorTop.begin;
			colorStopEnd   = this.playingGradientColorTop.end;
		} else {
			colorStopBeing = this.endGradientColorTop.begin;
			colorStopEnd   = this.endGradientColorTop.end;
		}

		grd.addColorStop(0, colorStopBeing);   
		grd.addColorStop(1, colorStopEnd);
		ctx.fillStyle = grd;
		ctx.fill();
		uiManager.restoreContext();
	}
}

QMail.UIAudioAttachment.prototype.showLoding = function() {

	if(this.element) {
		this.status = AudioStatus.loading;
		this.imgView.image = new QMail.UIImage.imageNamed(this.playLoadingImageUrl);
		this.labelFileSize.contextAttribute = this.filesizePlayingContextAttributes;
		this.labelFileName.contextAttribute = this.filenamePlayingContextAttributes;
		this.renderToElement(this.element);
	}
}

QMail.Events.mixTo(QMail.UIAudioAttachment);

})();

