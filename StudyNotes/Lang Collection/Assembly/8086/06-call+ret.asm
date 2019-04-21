assume cs:code, ds:data, ss:stack

stack segment   
    db 100 dup(0)
stack ends

data segment
    db 100 dup(0)
    string db 'Hello!$'
data ends 

code segment  
start:
    mov ax, data
    mov ds, ax                         
    mov ax, stack
    mov ss, ax
               
    call print    
    call print 
    call print 
    
    mov ax, 4c00h
    int 21h

print:
    ; ds:dx string address offset
    mov dx, offset string
    mov ah, 9h
    int 21h
    
    ret 
code ends

end start