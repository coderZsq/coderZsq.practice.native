assume cs:codesg
codesg segment
  s:  mov ax, bx ;mov ax, bx的机器码占两个字节
      mov si, offset s
      mov di, offset s0
      mov ax, cs:[si]
      mov cs:[di], ax
  s0: nop
      nop   ;nop的机器码占一个字节
codesg ends

end s