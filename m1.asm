data segment
m1 db 10,13, "Name:chandralekha$"
m2 db 10,13, "Roll no:61$"
m3 db 10,13, "Div:1$"
data ends
code segment
assume cs:code ,ds:data
start:
       mov ax,data
       mov ds,ax
       mov ah,09h
       lea dx,m1
       int 21h
       mov ah,09h
       lea dx,m2
       int 21h
       mov ah,09h
       lea dx,m3
       int 21h
       mov ah,4ch
       int 21h
       code ends
      end start
