assume cs:code, ds:data, ss:stack

stack segment   
    db 100 dup(0)
stack ends

data segment
    a dw 0
    db 100 dup(0)
    string db 'Hello!$'
data ends 

code segment  
start:
    mov ax, data
    mov ds, ax                         
    mov ax, stack
    mov ss, ax
               
    call mathFunc3 
    ;mov bx, [0]
    ;mov bx, a 
    mov bx, ax    
    
    mov ax, 4c00h
    int 21h

; return ax
mathFunc3:
    mov ax, 2
    add ax, ax
    add ax, ax
     
    ret

mathFunc2:
    mov ax, 2
    add ax, ax
    add ax, ax
    
    mov a, ax
     
    ret

mathFunc1:
    mov ax, 2
    add ax, ax
    add ax, ax
    
    mov [0], ax
     
    ret 
code ends

end start