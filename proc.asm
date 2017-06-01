data segment
m1 db 10,13,"Enter a 4 digit number: $"

data ends
code segment
assume cs:code, ds:data
start:mov ax,data
      mov ds,ax

        mov ah,09h
        lea dx,m1
        int 21h
        call read
        mov ah,4ch
        int 21h


        read proc near
        mov si,04
        mov cl,04
        mov bx,00

        a:mov ah,01h
        int 21h
        call convert
        shl bx,cl
        add bl,al
        dec si
        jnz a
        ret
        endp

        convert proc near
        cmp al, '9'
        jbe l1
        cmp al, 'a'
        jb l2
        sub al,57h
        jmp l3

        l1:sub al,30h
           jmp l3
        l2:sub al,37h
        l3:ret
           end p

code ends
end start
