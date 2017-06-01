xyz macro msg
        push ax
        push dx
        mov ah,09h
        lea dx,msg
        int 21h
        pop dx
        pop ax
endm

data segment
        m1      db      10,13,"Enter string : $"
        m2      db      10,13,"Reverse string : $"
        m3      db      10,13,"Length : $"
        m4      db      10,13,"Palindrom $"
        m5      db      10,13,"Not Palindrom $"
        buff    db      20,?,20 dup(0)
data ends

code segment

        ASSUME ds:data,cs:code
        start:
        mov ax,data
        mov ds,ax

        xyz m1
        mov ah,0ah
        lea dx,buff
        int 21h

        xyz m3
        mov al,buff+1
        mov ah,00
        AAM
        mov bx,ax
        or bx,3030h
        mov ah,02h

        mov dl,bh
        int 21h
        mov dl,bl
        int 21h

        xyz m2
        lea bx,buff
        mov cl,buff+1
        mov ch,00h

        mov di,cx

        mov ah,02h

    up: mov dl,[buff+1+di]
        int 21h
        dec di
        jnz up

        lea bx,buff
        mov cl,buff+1
        mov ch,0h
        mov si,0h
        mov di,cx


     u: mov al,[bx+2+si]
        mov dl,[bx+1+di]

        cmp al,dl
        jne np

        dec di
        inc si
        loop u


        xyz m4
        jmp r

   np:  xyz m5
        
    r:  mov ah,4ch
        int 21h

code ends
end start
