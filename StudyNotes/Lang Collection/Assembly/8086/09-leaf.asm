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
    
    push 1122h
    push 3344h
    call sum
    add sp, 4  
    
    push 1122h
    push 3344h
    call minus
    
    mov ax, 4c00h
    int 21h

sum:            
    mov bp, sp
    mov ax, ss:[bp + 2] 
    add ax, ss:[bp + 4] 
    
    push 1122h
    push 3344h
    call minus
           
    ret
    
minus:
    mov bp, sp
    mov ax, ss:[bp + 2]
    sub ax, ss:[bp + 4] 
     
    ret 4
     
code ends

end start