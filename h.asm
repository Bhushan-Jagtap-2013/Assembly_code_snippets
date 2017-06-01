Data segment
        msg1    db      10,13,"Enter how may number you want:$"
        msg2    db      10,13,"Enter Number:$"
        msg3    db      10,13,"Sum is:$"
        cnt     db      0
        sum     dw      0
Data ends
Code segment

        ASSUME cs:Code,ds:Data
        start:
        mov ax,Data
        mov ds,ax

        mov ah,09h
        lea dx,msg2
        int 21h

        ;addition
        mov cl,4
  bac  :
        ;call space
        call read
        add sum,bx
        dec cl
        jnz bac
        mov ax,sum

        mov ah,09h
        lea dx,msg3
        int 21h

        call disp

        ;close
        mov ah,4ch
        int 21h

        ;space proc
        space proc near
                push ax
                push dx
                mov ah,02h
                mov dl,' '
                int 21h
                pop dx
                pop ax
                ret
        endp

        ;display proc
        disp proc near
                push ax
                push dx
                push cx

                mov cl,04
                mov ch,04

          back: rol ax,cl
                push ax
                and al,0fh
                cmp al,9

                jbe l1
                cmp al,0ah
                jb l2
                add al,57h
                jmp dis
            l1: add al,30h
                jmp dis
            l2: add al,37h
           dis: mov ah,02h
                mov dl,al
                int 21h

                pop ax
                dec ch
                jnz back

                pop cx
                pop dx
                pop ax
                ret
        endp

        ;read procedure
        read proc near
                push cx
                push ax
                push dx
                mov si,02h
                mov cl,04h
           abc: mov ah,01h                        
                int 21h
                call convert
                shl bx,cl
                add bl,al
                dec si
                jnz abc
                mov bx,0000h
                pop dx
                pop ax
                pop cx
                ret
        endp
        convert proc near

                cmp al,'9'
                jbe l1
                cmp al,'a'
                jb ll2
                sub al,57h
                jmp ll3
           ll1: sub al,30h
                jmp ll3
           ll2: sub al,37h
           ll3: ret
        endp

Code ends
end start
