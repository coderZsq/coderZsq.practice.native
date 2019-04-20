assume cs:code, ds: data

data segment
  db 11h, 22h, 33h, 'Hello World!$'
data ends

code segment
start:   
   ; set ds value
   mov ax, data
   mov ds, ax
   
   ; print string       
   mov dx, 3h
   mov ah, 9h
   int 21h   
   
   mov ax, 4c00h
   int 21h
code ends

end start