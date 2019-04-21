assume cs:code, ds:data, ss:stack

stack segment   
    db 100 dup(0)
stack ends

data segment
    db 100 dup(0)
data ends 

code segment  
start:
    mov ax, data
    mov ds, ax                         
    mov ax, stack
    mov ss, ax
    
    push 1
    push 2
    call sum
    add sp, 4  
    
    mov ax, 4c00h
    int 21h

sum:
    push bp            
    mov bp, sp
    sub sp, 10 ;10 space for local variable
    
    mov word ptr ss:[bp - 2], 3         
    mov word ptr ss:[bp - 4], 4 
    mov ax, ss:[bp - 2]
    add ax, ss:[bp - 4]
    mov ss:[bp - 6], ax
    
    mov ax, ss:[bp + 4] ;arguments
    add ax, ss:[bp + 6] ;arguments
    add ax, ss:[bp - 6] ;local variable
    
    ;resume sp
    mov sp, bp
    ;resume bp 
    pop bp
    ret
     
code ends

end start