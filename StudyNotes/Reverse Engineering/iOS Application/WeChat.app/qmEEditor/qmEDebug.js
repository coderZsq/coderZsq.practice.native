/**
 * created : flyhuang
 * 管理调试信息，方便调试
 */
QMail.Debug = {
    level : 0,   //不打印日志
    log : function(str) {

        // QMail.NativeNotifier.notify('ioslog' , {
        //     str : str
        // });

        if(this.level < 1) {
            console.log.apply(console, [].slice.call(arguments));
        }
    },
    warn : function() {
        if(this.level < 2) {
            console.log.apply(console, [].slice.call(arguments));
        }
    },
    err : function(str) {
        if(this.level < 3) {
            console.log.apply(console, [].slice.call(arguments));
        }
    },
    showCursor : function() {

        var editor = QMail.Viewer.instance.editor;

        var paddedDiv = document.createElement('div');
        paddedDiv.addClass('qm-debug');
        paddedDiv.addClass('qm-debug-padded');
        paddedDiv.hide();

        var visibleDiv = document.createElement('div');
        visibleDiv.addClass('qm-debug');
        visibleDiv.addClass('qm-debug-visible');
        visibleDiv.hide();

        var paddedInfoDiv = document.createElement('div');
        paddedInfoDiv.addClass('qm-debug');
        paddedInfoDiv.addClass('qm-debug-paddedinfo');
        paddedInfoDiv.hide();

        var visibleInfoDiv = document.createElement('div');
        visibleInfoDiv.addClass('qm-debug');
        visibleInfoDiv.addClass('qm-debug-visibleinfo');
        visibleInfoDiv.hide();

        document.body.appendChild(paddedInfoDiv);
        document.body.appendChild(visibleInfoDiv);
        document.body.appendChild(paddedDiv);
        document.body.appendChild(visibleDiv);

        editor.on('makeRectVisible',function(paddedRect , vRect) {

            paddedDiv.style.left = paddedRect.left + 'px';
            paddedDiv.style.top = paddedRect.top + 'px';
            paddedDiv.style.width = paddedRect.width + 'px';
            paddedDiv.style.height = paddedRect.height + 'px';
            paddedDiv.show();

            var vBorder = 3;
            var vleft = vRect.left + 10;
            var vTop  = vRect.top;
            var vHeight = vRect.height - vBorder * 2; //4为border高度
            var vWidth = vRect.width - vBorder * 2; //4为border高度
            visibleDiv.style.left = vleft + 'px';
            visibleDiv.style.top = vTop + 'px';
            visibleDiv.style.width = vWidth + 'px';
            visibleDiv.style.height = vHeight + 'px';
            visibleDiv.show();

            var info = 'paddedRect:' + paddedRect.left + ' ' + paddedRect.top + ' ' + paddedRect.width + ' ' + paddedRect.height;
            var infoTop = vTop + 20;
            paddedInfoDiv.innerHTML = info;
            paddedInfoDiv.style.top = infoTop + 'px';
            paddedInfoDiv.show();

            var visibleInfo = 'vRect:' + vRect.left + ' ' + vRect.top + ' ' + vRect.width + ' ' + vRect.height;
            var visibleInfoTop = infoTop + 30; 
            visibleInfoDiv.innerHTML = visibleInfo;
            visibleInfoDiv.style.top = visibleInfoTop + 'px';
            visibleInfoDiv.show();
        });

        editor.on('stopEdit',function(paddedRect , vRect) {
            visibleDiv.hide();
            paddedDiv.hide();
            paddedInfoDiv.hide();
            visibleInfoDiv.hide();
        });

    }
}