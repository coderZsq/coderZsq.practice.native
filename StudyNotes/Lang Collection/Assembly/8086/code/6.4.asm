assume cs:code, ds:data, ss:stack

data segment
    
    dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h

data ends

stack segment

    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

stack ends

code segment

start:  mov ax, stack
        mov ss, ax
        mov sp, 20h     ;设置栈顶ss:指向stack:20

        mov ax, data
        mov ds, ax      ;ds指向data段

        mov bx, 0       ;ds:bx指向data段中的第一个单元

        mov cx, 8
    s:  push [bx]
        add bx, 2
        loop s          ;以上将data段中的0~15单元中的8个字型数据依次入栈

        mov bx, 0

        mov cx, 8
    s0: pop [bx]
        add bx, 2
        loop s0         ;以上依次出栈8个字型数据到data段的0~15单元中

        mov ax, 4c00h
        int 21h

code ends

end start