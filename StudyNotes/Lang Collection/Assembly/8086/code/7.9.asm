assume cs:codesg, ds:datasg

datasg segment
  db 'ibm             '
  db 'dec             '
  db 'dos             '
  db 'vax             '
datasg ends

codesg segment
start:
    mov ax, datasg
    mov ds, ax
    mov bx, 0

    mov cx, 4

s0: mov dx, cx          ;将外层循环的cx值保存在dx中
    mov si, 0
    mov cx, 3           ;cx设置为内层循环的次数

s:  mov al, [bx+si]
    and al, 11011111b
    mov [bx+si], al
    inc si
    loop s

    add bx, 16
    mov cx, dx          ;用dx中存放的外层循环计数值恢复cx
    loop s0             ;外层循环的loop指令将cx中的计数值减1

    mov ax, 4c00h
    int 21h

codesg ends

end start