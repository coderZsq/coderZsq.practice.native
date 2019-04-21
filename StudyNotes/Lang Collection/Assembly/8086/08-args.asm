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
    call sum3
    add sp, 4
    mov bx, ax 
    
    push 2222h
    push 2222h
    call sum3
    add sp, 4
    mov bx, ax
    
    push 3333h
    push 3333h
    call sum3
    add sp, 4
    mov bx, ax
    
    mov word ptr [0], 1122h 
    mov word ptr [2], 3344h          
    call sum2
    mov bx, ax 
    
    mov cx, 1122h
    mov dx, 3344h   
    call sum1
    
    mov ax, 4c00h
    int 21h

sum3:            
    mov bp, sp
    mov ax, ss:[bp + 2]
    add ax, ss:[bp + 4]
    ret


sum2:
    mov ax, [0]
    add ax, [2]
    ret

sum1:  
    mov ax, cx
    add ax, dx
    ret 
     
code ends

end start