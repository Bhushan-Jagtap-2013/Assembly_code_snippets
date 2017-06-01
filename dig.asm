data segment
m1 db 10,13,"Enter a number: $"
m2 db 10,13,"Entered number: $"
data ends
code segment
assume cs:code, ds:data
start:mov ax,data
      mov ds,ax
        mov ah,09h
        lea dx,m1
        int 21h

        mov ah,01h
        int 21h
        mov bl,al

        mov ah,01h
        int 21h
        mov cl,al

        mov ah,09h
        lea dx,m2
        int 21h

         mov ah,02h
        mov dl,bl
        int 21h

        mov ah,02h
        mov dl,cl
        int 21h

mov ah,4ch
int 21h
code ends
end start



