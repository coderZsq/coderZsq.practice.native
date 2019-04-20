assume cs:code

code segment 
    
    mov ax, 1122h
    mov bx, 3344h
    add ax, bx
                
    ; exit program       
    mov ax, 4c00h
    int 21h 
     
code ends 

end