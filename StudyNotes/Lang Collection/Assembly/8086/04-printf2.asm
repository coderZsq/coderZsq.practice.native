; just remind to developer 
assume cs:code, ds:data

data segment 
    age db 20h
    no dw 30h 
    db 10 dup(6)                              
    string db 'Hello World!$'
data ends

code segment
start:    
    mov ax, data
    mov ds, ax    
     
    mov ax, no
    mov bl, age 
     
    mov dx, offset string
    mov ah, 9h
    int 21h  
    
    mov ax, 4c00h
    int 21h
code ends

end start