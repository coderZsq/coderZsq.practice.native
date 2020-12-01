mov ax, seg
mov ds, ax
mov bx, 60h ;确定记录地址, ds:bx

mov word ptr [bx+0ch], 38 ;排名字段改为38
add word ptr [bx+0eh], 70 ;收入字段增加70

mov si, 0  ;用si来定位产品字符串中的字符
mov byte ptr [bx+10h+si], 'V'
inc si
mov byte ptr [bx+10h+si], 'A'
inc si
mov byte ptr [bx+10h+si], 'X'
