data segment
data ends
code segment
        ASSUME cs:code,ds:data
        start:

        mov ax,data
        mov ds,ax


        call B2H

        mov ah,4ch
        int 21h
        dism macro msg
                push ax
                push dx

                mov ah,09h
                lea dx,msg
                int 21h

                pop dx
                pop ax

        endm

        H2B proc near
                push ax
                push bx
                push cx
                push dx
                push si
                push di

                call read
                mov ax,bx
                mov bx,10
                mov cx,0h
            u:  mov dx,0h

                div bx
                push dx
                inc cx
                or ax,ax
                jnz u

           u1:  mov dx,0h
                mov ah,02h

                pop dx

                add dl,30h
                int 21h
                loop u1

                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax

        ret 
        endp
        B2H proc near
                push ax
                push bx
                push cx
                push dx
                push si
                push di

                mov si,02h
                mov cx,10
                mov bx,00h

            u3: mov ah,01h
                int 21h
         
                sub al,30h

                push ax

                mov ax,bx
                mul cx

                mov bx,ax

                pop ax
                mov ah,0h

                add bx,ax

                dec si
                jnz u3

                mov ax,bx

                call disp

                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax

        ret 
        endp

        disp proc near
                push ax
                push bx
                push cx
                push dx
                push si
                push di

                mov si,04
                mov cl,04

          q:    rol ax,cl
                push ax

                and al,0fh
              
                cmp al,9
                jbe a2
                add al,37h
                jmp r1
          a2:   add al,30h

          r1:   mov dl,al
                mov ah,02h

                int 21h

                pop ax

                dec si
                jnz q

                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax

        ret 
        endp
        conv proc near
                push bx
                push cx
                push dx
                push si
                push di


                cmp al,'9'
                jbe l1
                cmp al,'a'
                jb l2
                sub al,57h
                jmp r
          l1:   sub al,30h
                jmp r
          l2:   sub al,37h

          r:    pop di
                pop si
                pop dx
                pop cx
                pop bx
        ret
        endp

        read proc near
                push ax
                push cx
                push dx
                push si
                push di

                mov si,02
                mov cl,04
                mov bx,0h

           up:  mov ah,01h
                int 21h
                call conv

                shl bx,cl
                and al,0fh

                add bl,al
                dec si
                jnz up

                pop di
                pop si
                pop dx
                pop cx
                pop ax

        ret 
        endp

code ends
end start
