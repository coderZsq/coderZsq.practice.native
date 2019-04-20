assume cs:code, ds:data, ss:stack

stack segment
    db 10 dup(0)
stack ends

data segment
    db 20 dup(0)
data ends

code segment
start:
    mov ax, stack
    mov ss, ax
    mov ax, data
    mov ds, ax
    
    mov ax, 1122h
    mov bx, 3344h    
    
    mov sp, 10
    push ax
    push bx
    pop ax
    pop bx
    
    mov ax, 4c00h
    int 21h         
code ends

end start