assume cs:codesg, ds:datasg

datasg segment
  db 'BaSic'
  db 'iNfOrMaTiOn'
datasg ends

codesg segment
  start:  mov ax, datasg      ;设置ds指向datasg段
          
          mov bx, 0           ;设置(bx)=0, ds:bx指向'BaSiC'的第一个字母

          mov cx, 5           ;设置循环次数5, 因为'BaSic'有5个字母
      s:  mov al, [bx]        ;将ASCII码从ds:bx所指向的单元中取出
          and al, 11011111B   ;将al中的ASCII码的第5位置为0, 变为大写字母
          mov [bx], al        ;将转变后的ASCII码写回原单元
          inc bx              ;(bx)加1, ds:bx指向下一个字母
          loop s

          mov bx, 5           ;设置(bx)=5, ds:bx指向'iNfOrMaTiOn'的第一个字母

          mov cx, 11          ;设置循环次数11, 因为'iNfOrMaTiOn'有11个字母
      s0: mov al, [bx]
          or  al, 00100000B   ;将al中的ASCII码的第5个位置为1, 变为小写字母
          mov [bx], al
          inc bx
          loop s0

          mov ax, 4c00h
          int 21h

codesg ends
end start