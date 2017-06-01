data segment

        m1      db      10,13,"Enter how many num? $"
        m2      db      10,13,"Enter num : $"
        m3      db      10,13,"SUM : $"
        sum     dw      0h
data ends

code segment

        ASSUME ds:data,cs:code
        start:

        mov ax,data
        mov ds,ax

        mov ah,09h
        lea dx,m1
        int 21h

        call read
        mov cx,bx

        mov ah,09h
        lea dx,m2
        int 21h

    u:  call read
        mov ax,bx
        add sum,ax

        call space

        dec cx
        jnz u

        mov ah,09h
        lea dx,m3
        int 21h

        mov ax,sum
        call disp

        mov ah,4ch
        int 21h


        read proc near

                push ax
                push cx
                push dx

                mov si,02
                mov cl,04
                mov bx,0h

          xyz:  mov ah,01h
                int 21h

                call con

                shl bx,cl
                add bl,al
                dec si
                jnz xyz

                pop dx
                pop cx
                pop ax

        ret
        endp
        
        con proc near

                push bx
                push cx
                push dx

                cmp al,'9'
                jbe l1
                cmp al,'a'
                jb l2
                sub al,57h
                jmp r
           l1:  sub al,30h
                jmp r
           l2:  sub al,37h
              
           r:   pop dx
                pop cx
                pop bx

        ret
        endp
        space proc near

                push ax
                push bx
                push cx
                push dx
                push si
                push di

                mov ah,02h
                mov dl,' '
                int 21h

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

                mov cl,04
                mov ch,04

          up:   rol ax,04
                push ax

                and al,0fh

                cmp al,9h
                jbe x
                add al,37h
                jmp r1
          x:    add al,30h
          r1:
                mov dl,al
                mov ah,02h
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
