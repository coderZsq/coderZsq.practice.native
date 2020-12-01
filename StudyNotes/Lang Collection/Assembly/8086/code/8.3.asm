mov ax, seg
mov ds, ax
mov bx, 60h ;记录首址送BX

mov ax, seg
mov ds, ax
mov bx, 60h ;确定记录地址, ds:bx

mov word ptr [bx].0ch, 38 ;排名字段改为38
                          ;C: dec.pm=38;
add word ptr [bx].0eh, 70 ;收入字段增加70
                          ;C: dec.sr=dec.sr+70;
                          ;产品字段改为字符串'VAX'
mov si, 0 ;C: i = 0;
mov byte ptr [bx].10h[si], 'V' ;dec.cp[i]='V';
inc si  ;i++;
mov byte ptr [bx].10h[si], 'A' ;dec.cp[i]='A';
inc si  ;i++;
mov byte ptr [bx].10h[si], 'X' ;dec.cp[i]='X';
