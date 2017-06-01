Data segment
        m1      db      10,13,"Enter digit:$"
        m2      db      10,13,"Entered Number is:$"
Data ends
Code segment

        ASSUME cs:Code,ds:Data
        start:
        mov ax,Data
        mov ds,ax

        mov ah,09h
        lea dx,m1
        int 21h

        mov ah,01h
        int 21h
        mov bl,al

        mov ah,01h
        int 21h
        mov bh,al

        mov ah,09h
        lea dx,m2
        int 21h

        mov ah,02h
        mov dl,bl
        int 21h

        mov ah,02h
        mov dl,bh
        int 21h

        mov ah,4ch
        int 21h

Code ends
end start
