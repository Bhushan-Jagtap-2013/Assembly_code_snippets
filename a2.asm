data segment
        m1      db      10,13,"Destination block : $"
        arr1    db      1,2,3,4,?,?
        ;arr2    db      4 dup(0)
data ends
code segment
        ASSUME ds:data,cs:code
        start:

        mov ax,data
        mov ds,ax
        mov es,ax


        lea si,[arr1+3]
        lea di,[arr1+5]

        mov cx,04h
        std
        rep movsb


        mov cx,06h
        lea si,arr1

   u:  mov al,[si]
        call disp
        inc si
        loop u


        mov ah,4ch
        int 21h

        disp proc near
                push ax
                push bx
                push cx
                push dx
                push si
                push di

                mov cl,04
                mov ch,02

                mov ah,0h
           up:  rol al,cl
                push ax

                and al,0fh
                cmp al,9
                jbe x
                add al,37h
                jmp r
           x:   add al,30h

           r:   mov ah,02h
                mov dl,al
                int 21h
                pop ax

                dec ch
                jnz up


                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax
        ret
        endp
code ends
end start
