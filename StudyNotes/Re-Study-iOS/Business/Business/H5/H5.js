window.onload = function() {
    var allImg = document.getElementsByTagName('img');
    for (var i = 0; i < allImg.length; i++) {
        var img = allImg[i];
        img.id = i;
        img.onclick = function() {
//            alert('点击了第' + this.id + '张图片!!');xxe
            this.style.width = '100%';
            window.location.href = 'business://openCamera';
        }
    }
};
