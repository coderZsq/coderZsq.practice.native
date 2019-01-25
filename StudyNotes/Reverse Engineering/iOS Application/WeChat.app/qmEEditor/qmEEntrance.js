/**
 * created by flyhuang 
 * 编辑器的入口初始化函数
 */


QMail.config.tapBodyToEnd = true;

QMail.domReady(function() {

    //当默认的currScale为1,0才缩放
    if(window.currScale * 10 == 10) {
        QMail.Viewer.viewport.on('beforeScaleTofix',function(scale){

            QMail.NativeNotifier.notify('setWebViewScaleFromJS', {
              scale : scale
            });
            //去掉该class保证自适应屏幕后图片布局不会因为mail_didload而影响
            document.getElementById('QMEditor').removeClass('editordidload');
        });
        //开启自动缩放  
        QMail.Viewer.viewport.shouldScaleToFix = true;
    }
    //开启图片loading的边框
    QMail.Viewer.instance.showImageLoading = true;
    QMail.Viewer.instance.ready();

    //清除空的apple-style-span
    QMail.Viewer.instance.rootElement.removeEmptyAppleStyleSpans();

     //将原始的audio标签替换为app需要展现的形式
    QMail.AttachmentManager.shareInstance.makeElementsToAttachments();

    //保存初始化时的文本用于比较差异
    QMail.Diffs.shareInstance.saveCurrentText();

    QMail.NativeNotifier.notify('domContentLoadedFromJs');

    //用于debug光标位置的
    // QMail.Debug.showCursor();
               
               
});
