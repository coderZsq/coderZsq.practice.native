assume cs:codesg
codesg segment
  start:mov ax, offset start ;相当于mov ax, 0
      s:mov ax, offset s     ;相当于mov ax, 3
codesg ends
end start