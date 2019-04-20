assume cs:code

code segment
   db 55h, 66h, 77h, 88h
   db 10 dup(0)
   
start:   
   mov ax, cs:[0]
   mov bx, cs:[2]
   
   ; exit program
   mov ax, 4c00h
   int 21h
    
code ends                                                       ; 

; program entry start
end start





