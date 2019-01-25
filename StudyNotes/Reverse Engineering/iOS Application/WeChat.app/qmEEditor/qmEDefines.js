/**
 * created by flyhuang 
 * 编辑器的常量定义值
 */

var QMail = {
    versions : '0.1.0',
    config   : {
        contentId      : 'QMEditor',
        editorId       : 'QMEditor',
        caretMaker     : '&#8203;',   //占位符号
        fixImgMaxWidth : 295,
        fixImgMaxWidthLandspace : 440,
        notifyName     : 'qmeditor',
        tailId         : 'editPlace',
        tapBodyToEnd   : true
    },
    CONST : {
        QM_INSERTED_AUDIO_TAG_NAME        : "object",
        QM_INSERT_ATTACHMENT_CLASS_NAME   : "qmeditor-attach",
        QM_INSERT_IMAGE_CLASS_NAME        : "qmeditor-image",
        QM_INSERTED_ELEMENT_CLASSNAME     : "qm-inserted",
        QM_INSERT_NATIVE_AUDIO_CLASSNAME  : 'ios-upload-audio',
        QM_INSERT_AUDIO_CLASSNAME         : 'ios-upload-qmaudio',
        QM_INSERT_AUDIO_END_CLASSNAME     : 'ios-upload-end',
        QM_INSERT_AUDIO_PLAY_CLASSNAME    : 'ios-upload-playing'
    },
    domReady : function(callback) {
        document.addEventListener('DOMContentLoaded', function () {
            callback && callback();
        });
    }
}
