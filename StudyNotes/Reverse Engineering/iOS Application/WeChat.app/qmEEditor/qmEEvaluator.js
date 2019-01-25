/**
 * created by flyhuang 
 * uiwebview调用js的函数入口集合，统一管理
 */
QMail.evaluator = {};

//切换编辑器的可编辑态
QMail.evaluator.setEditableState = function(toState) {
    if(toState) {
        QMail.Viewer.instance.startEdit();
    } else {
        QMail.Viewer.instance.stopEdit();
    }
}

//object-c 通知js端 可见区域的高度，以及初始状态headerBar的默认显示高度
QMail.evaluator.setWindowVisibleHeight = function(height , initialWidth , initialHeight) {
    QMail.Viewer.instance.editor.setDefaultVisibleHeight(height , initialWidth , initialHeight);
}

//object-c 通知js端 当前准确的contentOffset，一般来说js就能拿到，但是由于object-c端hack了原生的方法，导致某些情况下还有当前是负值的时候拿不到准确的contentOffset
QMail.evaluator.setCurrentOffset = function(x , y) {
    QMail.Viewer.instance.editor.updateCurrentOffset(x , y);
}

QMail.evaluator.excuteBridgeCallback = function() {
    QMail.NativeNotifier.excuteCallback.apply(QMail.NativeNotifier , [].slice.apply(arguments));
}

//处理来自粘贴的附件，将其保存到本地
QMail.evaluator.saveAttachmentsByPaste = function() {
    return QMail.Viewer.instance.editor.saveAttachmentsByPaste();
}

//成功保存后处理粘贴的图片
QMail.evaluator.markPasteImageSaved = function(imageIds , pasteImageAttachMents) {
    return QMail.Viewer.instance.editor.markPasteImageSaved(imageIds , pasteImageAttachMents);
}

//插入一个附件
QMail.evaluator.insertAttachment = function(attachInfo , otherOption) {
    QMail.Viewer.instance.editor.insertAttachment(attachInfo , otherOption);
}

QMail.evaluator.getBodyHeight = function() {
    return document.body.scrollHeight;
}

QMail.evaluator.getTextHeight = function() {
    return QMail.Viewer.instance.editor.getTextHeight();
}

QMail.evaluator.getTextWidth = function() {
    return QMail.Viewer.instance.editor.getTextWidth();
}

QMail.evaluator.setSpaceUponKeyboard = function(space) {
    return QMail.Viewer.instance.editor.setSpaceUponKeyboard(space);
}

//objec-c 端获得焦点
QMail.evaluator.becomeFirstResponder = function() {
    QMail.Viewer.instance.restoreStart();
    return true;
}

//objec-c 失去焦点
QMail.evaluator.resignFirstResponder = function() {
    QMail.evaluator.setEditableState(false);
    return true;
}

QMail.evaluator.becomBrowserFirstResponder = function() {
    
}

//不要在此再调用blur，会导致core
QMail.evaluator.resignBrowserFirstResponder = function() {
    
}

QMail.evaluator.getHtml = function() {
    return QMail.Viewer.instance.editor.getInnerHtml();
}

QMail.evaluator.setHtml = function(html) {
    QMail.Viewer.instance.editor.setInnerHtml(html);
}

//可以用来判断文本是否变化
QMail.evaluator.hasChanges = function() {
    return QMail.Viewer.instance.editor.hasChanges();
}

QMail.evaluator.playAudio = function(id) {
    var uiAttachment = QMail.AttachmentManager.shareInstance.getAttachmentById(id);
    if(uiAttachment) {
        QMail.Viewer.instance.editor.playAudio(uiAttachment);
        return true;
    } else {
        return false;
    }
}

QMail.evaluator.stopAudio = function(id) {
    var uiAttachment = null;
    if(id) {
        uiAttachment = QMail.AttachmentManager.shareInstance.getAttachmentById(id);
    }
    QMail.Viewer.instance.editor.stopAudio(uiAttachment);
}

QMail.evaluator.loadAudio = function(id) {
    var uiAttachment = QMail.AttachmentManager.shareInstance.getAttachmentById(id);
    if(uiAttachment) {
        QMail.Viewer.instance.editor.loadAudio(uiAttachment);
    }
}

//获取当前web的缩放尺寸
QMail.evaluator.getWebScale = function() {
    return QMail.Viewer.viewport.scale;
}

//获取附件信息
QMail.evaluator.getAttachments = function() {
    var result = {
        attachments : QMail.AttachmentManager.shareInstance.getAttachments()
    }
    return JSON.stringify(result);
}

//供objec-c端调用保存当前的选择区域
QMail.evaluator.storeCurrentSelection = function() {
    var editor = QMail.Viewer.instance.editor;
    editor.storeCurrentSelection();
}

///////////////以下方法供富文本编辑器使用/////////////////////////
QMail.evaluator.executeCommands = function(commands) {
    var editor = QMail.Viewer.instance.editor;
    editor.executeCommands(commands);
}

QMail.evaluator.insertOrderedList = function() {
    var editor = QMail.Viewer.instance.editor;
    return editor.insertOrderedList();
}

QMail.evaluator.insertUnorderedList = function() {
    var editor = QMail.Viewer.instance.editor;
    return editor.insertUnorderedList();
}

QMail.evaluator.indent = function() {
    var editor = QMail.Viewer.instance.editor;
    return editor.indent();
}

QMail.evaluator.outdent = function() {
    var editor = QMail.Viewer.instance.editor;
    return editor.outdent();
}

QMail.evaluator.formatBlock = function(value , preserveStyles) {
    var editor = QMail.Viewer.instance.editor;
    return editor.formatBlock(value , preserveStyles);
}

QMail.evaluator.resetHtmlToText = function() {
    var editor = QMail.Viewer.instance.editor;
    editor.resetHtmlToText();
    QMail.AttachmentManager.shareInstance.consitentAttachmentsInCaseChanges();
}

QMail.evaluator.normalizeTextForElement = function() {
    var editor = QMail.Viewer.instance.editor;
    editor.normalizeTextForElement(editor.rootElement , {
        'background-color' : 'white'
    });
}

QMail.evaluator.insertCheckbox = function() {
    var editor = QMail.Viewer.instance.editor;
    return editor.insertCheckbox(false);
}

QMail.evaluator.applyHyperlink = function(href , title) {
    var editor = QMail.Viewer.instance.editor;
    editor.applyHyperlink(href , title);
}

QMail.evaluator.queryCommandValue = function(command) {
    var editor = QMail.Viewer.instance.editor;
    return editor.queryCommandValue(command);
}

QMail.evaluator.queryCommandEnabled = function(command) {
    var editor = QMail.Viewer.instance.editor;
    return editor.queryCommandEnabled(command);
}

QMail.evaluator.tryGetCurrentSelectionLinkInfo = function() {
    var editor = QMail.Viewer.instance.editor;
    editor.storeCurrentSelection();
    var link = editor.getCurrentSelectionParentElementByTagName("a");

    if(link) {
        return JSON.stringify({
            title : link.innerHTML || '',
            href  : link.getAttribute('href'),
            hasSelection : editor.hasTextSelection()
        });
    } else {
        return false;
    }
}

//获取上次产生变化的附件信息，如果信息很多的话通过url由于长度限制可能被截断，所以使用这种方案
QMail.evaluator.fetchLastChangesAttachmentsInfo = function() {

    var changesInfo = QMail.AttachmentManager.shareInstance.lastChangesAttachmentsInfo;
    var delSrcs = [];

    if(changesInfo) {
        var dels = changesInfo.dels;
        for (var i = 0; i < dels.length; i++) {
            delSrcs.push(dels[i].filePath);
        };
    } 

    return JSON.stringify(delSrcs);
}

QMail.evaluator.fetchLastDeleteAttachmentsInfo = function() {

    var changesInfo = QMail.AttachmentManager.shareInstance.lastChangesAttachmentsInfo;
    var delSrcs = [];

    if(changesInfo) {
        var dels = changesInfo.dels;
        for (var i = 0; i < dels.length; i++) {
            delSrcs.push(dels[i].filePath);
        };
    } 

    return JSON.stringify(delSrcs);
}
