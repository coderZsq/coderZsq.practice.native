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
    
    mov si, 1
    mov di, 2
    mov bx, 3
    mov bp, 4
    
    push 1
    push 2
    call sum
    add sp, 4  
    
    mov ax, 4c00h
    int 21h

sum:
    push bp ;protect bp            
    mov bp, sp ;protect sp
    sub sp, 10 ;10 space for local variable
    
    ;protect register
    push si
    push di
    push bx
    
    ;insert int 3 (CCCC) into local varibale space 
    ;stosw is ax rigster value copy to es:di and di + 2
    mov ax, 0cccch
    mov bx, ss
    mov es, bx
    mov di, bp
    sub di, 10 ;sub to local varibale space
    mov cx, 5 ;cx register is args for repeat  
    rep stosw
    
    mov word ptr ss:[bp - 2], 3         
    mov word ptr ss:[bp - 4], 4 
    mov ax, ss:[bp - 2]
    add ax, ss:[bp - 4]
    mov ss:[bp - 6], ax
    
    mov ax, ss:[bp + 4] ;arguments
    add ax, ss:[bp + 6] ;arguments
    add ax, ss:[bp - 6] ;local variable
     
    ;resume register
    pop bx
    pop di
    pop si
    ;resume sp
    mov sp, bp
    ;resume bp 
    pop bp
    ret
     
code ends

end start