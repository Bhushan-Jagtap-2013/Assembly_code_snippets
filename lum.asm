data segment
m1 db 10,13,'Enter two digit no $'
data ends

code segment
assume cs :code ds :data
start :
mov ax,data
mov ds,ax

mov ah,09h
lea dx,m1
int 21h    

mov ah ,01h
int 21h

mov ah ,01h
int 21h

mov ah,4ch
int 21h

code ends
end start
