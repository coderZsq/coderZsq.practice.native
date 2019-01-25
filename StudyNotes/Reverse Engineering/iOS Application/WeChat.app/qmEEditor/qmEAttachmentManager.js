/**
 * created : flyhuang
 * 提供附件变化的通知和管理，删除和添加，考虑到用户的撤销
 */
QMail.AttachmentManager = function() {

	this.init();
}

//定义附件的类型
QMail.AttachmentManager.KNOWN_TYPE = -1;
QMail.AttachmentManager.IMAGE_TYPE = 0;
QMail.AttachmentManager.AUDIO_TYPE = 1;

QMail.AttachmentManager.getShareInstance = (function() {

	var _instance = null;

	return function(){

		if(!_instance) {
			_instance = new QMail.AttachmentManager();
		}

		return _instance;
	};
})();

QMail.AttachmentManager.__defineGetter__("shareInstance", QMail.AttachmentManager.getShareInstance);

QMail.AttachmentManager.prototype._lastChangesAttachmentsInfo = null;

QMail.AttachmentManager.prototype.init = function() {
	this._attachments = {};
	this.__defineGetter__("lastChangesAttachmentsInfo", this.getLastChangesAttachmentsInfo);
}

QMail.AttachmentManager.prototype.getLastChangesAttachmentsInfo = function() {
	return this._lastChangesAttachmentsInfo;
}

QMail.AttachmentManager.prototype.addAttachment = function(uiAttachment) {

	if(uiAttachment) {
		this._attachments[uiAttachment.attachId] = uiAttachment;
	}
}

QMail.AttachmentManager.prototype.removeAttachment = function(attachId) {

	if(attachId && this._attachments[attachId]) {
		var delAttachment = this._attachments[attachId];
		this._attachments[attachId] = null;
		delAttachment.destroy();
		delete delAttachment;
	}
}

QMail.AttachmentManager.prototype.getAttachmentById = function(id) {

	if(id) {
		return this._attachments[id];
	} else {
		return null;
	}
}

//查找所有需要管理的附件的elements，注意如果多平台的话需要各个平台统一选择器
QMail.AttachmentManager.prototype.queryAllAttachmentsElements = function() {
	var editor    = QMail.Viewer.instance.editor;
	var elements  = editor.rootElement.querySelectorAll('.' + QMail.CONST.QM_INSERT_ATTACHMENT_CLASS_NAME);
	return elements;
}

QMail.AttachmentManager.prototype.queryAllUnresolvedAttachmentsElements = function() {
	var editor    = QMail.Viewer.instance.editor;
	var elements  = editor.rootElement.querySelectorAll('.' + QMail.CONST.QM_INSERT_ATTACHMENT_CLASS_NAME);
	return elements;
}

//从attachment中获取attachInfo，注意如果多平台的话需要各个平台统一属性
QMail.AttachmentManager.prototype.getAttachmentFromElement = function(element) {

	if (element) {
		var nodeName  = element.nodeName.toUpperCase();
		var audioClassName = QMail.CONST.QM_INSERT_AUDIO_CLASSNAME;

		if(nodeName == 'IMG') {
			return {
				filePath    : element.getAttribute('qm-filePath') || element.getAttribute('src'),
				fileSize    : element.getAttribute('qm-fileSize') || 0,
				fileName    : element.getAttribute('qm-fileName') || element.getAttribute('title'),
				fileType    : element.getAttribute('qm-fileType') || QMail.AttachmentManager.IMAGE_TYPE
			}
		} else if(element.hasClass(audioClassName)){
			return {
				filePath    : element.getAttribute('qm-filePath') || element.getAttribute('src'),
				fileSize    : element.getAttribute('qm-fileSize') || 0,
				fileName    : element.getAttribute('qm-fileName'),
				fileType    : element.getAttribute('qm-fileType') || QMail.AttachmentManager.AUDIO_TYPE
			}
		} 
	}

	return {
		fileType : QMail.AttachmentManager.KNOWN_TYPE
	};
}

//将附加的附件信息添加到element，注意如果多平台的话需要各个平台统一属性
QMail.AttachmentManager.prototype.addAttachInfoToElement = function(attachInfo , element) {

	if(element) {
		element.setAttribute("qm-filePath", attachInfo.filePath);
		element.setAttribute("qm-fileType", attachInfo.fileType);
	    element.setAttribute("qm-fileSize", attachInfo.fileSize);
	    element.setAttribute("qm-fileName", attachInfo.fileName);

	    if(attachInfo.fileType == QMail.AttachmentManager.IMAGE_TYPE) {
	    	element.addClass(QMail.CONST.QM_INSERT_IMAGE_CLASS_NAME);
	    } else if(attachInfo.fileType == QMail.AttachmentManager.AUDIO_TYPE){
	    	element.addClass(QMail.CONST.QM_INSERT_AUDIO_CLASSNAME);
	    }

	    element.addClass(QMail.CONST.QM_INSERT_ATTACHMENT_CLASS_NAME);
	}
}

QMail.AttachmentManager.prototype.getAttachments = function() {

	var editor      = QMail.Viewer.instance.editor;
	var elements    = this.queryAllAttachmentsElements();
	var attachInfos = [];

	for (var i = 0; i < elements.length; i++) {
		var elem = elements[i];
		if(elem && elem.getAttachId()) {
			var attachmentUi = this.getAttachmentById(elem.getAttachId());
			attachmentUi && attachInfos.push(attachmentUi.attachInfo);
		}	
	};

	return attachInfos;
}

QMail.AttachmentManager.prototype.makeElementsToAttachments = function() {

	var editor    = QMail.Viewer.instance.editor;
	var elements  = this.queryAllUnresolvedAttachmentsElements();
	var uiManager = QMail.UIManager.shareInstance;
	var self      = this;

	uiManager.resourcesReady(function() {
		editor.igoresChange(true);
		for (var i = 0; i < elements.length; i++) {
			try {
				var element    = elements[i];
				var attachInfo = self.getAttachmentFromElement(element);

				//防止重复执行导致重复创建id导致附件变化不正确而引起错误的通知
				if(element && element.getAttachId()) {
					self.removeAttachment(element.getAttachId());
				}

				if(self.isAudioAttachment(attachInfo.fileType)) {
					var newElement = document.createElement(QMail.CONST.QM_INSERTED_AUDIO_TAG_NAME);
					newElement     = element.replace(newElement);
					newElement.className = element.className;
					newElement.removeClass(QMail.CONST.QM_INSERT_NATIVE_AUDIO_CLASSNAME);
					newElement.addClass(QMail.CONST.QM_INSERT_AUDIO_CLASSNAME);
					self.addAttachInfoToElement(attachInfo,newElement);
					var audioUi    = new QMail.UIAudioAttachment(newElement , attachInfo);
					audioUi.showEnding();
					self.addAttachment(audioUi);
				} else if(self.isImageAttachment(attachInfo.fileType)) {
					var imgAttachment = new QMail.UIAttachment(element,attachInfo);
					self.addAttachment(imgAttachment);
				}
			} catch(e) {
				QMail.Debug.err('replaceElementsToAudioAttachments error:' + e.message);
			}
		}
		editor.igoresChange(false);
	});
}

QMail.AttachmentManager.prototype.isImageAttachment = function(type) {
	return parseInt(type , 10) == QMail.AttachmentManager.IMAGE_TYPE;
} 

QMail.AttachmentManager.prototype.isAudioAttachment = function(type) {
	return parseInt(type , 10) == QMail.AttachmentManager.AUDIO_TYPE;
} 

QMail.AttachmentManager.prototype.restoreAttachmentsToElements = function() {

	var editor   = QMail.Viewer.instance.editor;
	var elements = this.queryAllAttachmentsElements();
	var self     = this;

	editor.igoresChange(true);

	for (var i = 0; i < elements.length; i++) {
		var element    = elements[i];
		var attachInfo = this.getAttachmentFromElement(element);
		if(self.isAudioAttachment(attachInfo.fileType)) {
			var newElement = document.createElement('audio');
			newElement     = element.replace(newElement);
			newElement.addClass(QMail.CONST.QM_INSERT_NATIVE_AUDIO_CLASSNAME);
			newElement.removeClass(QMail.CONST.QM_INSERT_AUDIO_CLASSNAME);
			this.addAttachInfoToElement(attachInfo,newElement);
		}
	}
	editor.igoresChange(false);
}

QMail.AttachmentManager.prototype.consitentAttachmentsInCaseChanges = function() {

	var editor   = QMail.Viewer.instance.editor;
	var elements = this.queryAllAttachmentsElements();
	var deletesAttachments  = [];
	var addElements         = [];
	var existElements       = {};

	for (var i = 0; i < elements.length; i++) {
		var element = elements[i];
		var attachId = element.getAttachId();
		existElements[attachId] = element;
		if(!this.getAttachmentById(attachId)) {
			addElements.push(element);
		}
	};

	for (var id in this._attachments) {
		if(!existElements[id] && this._attachments[id]) {
			deletesAttachments.push(this._attachments[id]);
		}
	};

	if(addElements.length >0 && deletesAttachments.length > 0) {
		// QMail.Debug.log('has add and delete');
		this.notifyChanges(addElements , deletesAttachments);
		this.markElementsAdd(addElements);
		this.markAttachmentsDelete(deletesAttachments);
	} else if(addElements.length > 0) {
		// QMail.Debug.log('has add elements');
		this.notifyChanges(addElements , []);
		this.markElementsAdd(addElements);
	} else if(deletesAttachments.length > 0) {
		// QMail.Debug.log('has delete attachments');
		this.notifyChanges([] , deletesAttachments);
		this.markAttachmentsDelete(deletesAttachments);
	} else {
		// QMail.Debug.log('no changes');
	}

	QMail.Debug.log(this.getAttachments());
}

QMail.AttachmentManager.prototype.notifyChanges = function(addElements, delAttachments) {

	var addIds = [] , delIds = [];

	this._lastChangesAttachmentsInfo = {
		adds : [],
		dels : []
	};

	for (var i = 0; i < addElements.length; i++) {
		var attachId   = addElements[i].getAttachId();
		var attachment = this.getAttachmentById(attachId);
		addIds.push(attachId);
		this._lastChangesAttachmentsInfo.adds.push(attachment.attachInfo);
	};

	for (var i = 0; i < delAttachments.length; i++) {
		var attachment = delAttachments[i];
		var attachId   = attachment.attachId;
		delIds.push(attachId);
		this._lastChangesAttachmentsInfo.dels.push(attachment.attachInfo);
	};

	var notifyInfo = {};

	if(addIds.length > 0 ) {
		notifyInfo.addIds = addIds.join(',');
	}

	if(delIds.length > 0 ) {
		notifyInfo.delIds = delIds.join(',');
	}

	QMail.NativeNotifier.notify('attachmentsChangedFromJs' , notifyInfo);
}

QMail.AttachmentManager.prototype.markAttachmentsDelete = function(deletesAttachments) {

	for (var i = 0; i < deletesAttachments.length; i++) {
		var delAttachment = deletesAttachments[i];
		this.removeAttachment(delAttachment.attachId);
	};
} 

QMail.AttachmentManager.prototype.markElementsAdd = function(addElements) {

	var uiManager = QMail.UIManager.shareInstance;
	var self = this;

	uiManager.resourcesReady(function() {
		var editor    = QMail.Viewer.instance.editor;
		editor.igoresChange(true);
		for (var i = 0; i < addElements.length; i++) {
			var addElement = addElements[i];
			var attachInfo = self.getAttachmentFromElement(addElement);

			if(self.isImageAttachment(attachInfo.fileType)) {
				var imgAttachment = new QMail.UIAttachment(addElement,attachInfo);
				self.addAttachment(imgAttachment);
			} else if(self.isAudioAttachment(attachInfo.fileType)) {
				var audioUi    = new QMail.UIAudioAttachment(addElement , attachInfo);
				audioUi.showEnding();
				self.addAttachment(audioUi);
			}
		};
		editor.igoresChange(false);
	});
} 