 
Data segment

        m1 db 10,13," Enter a Number :- $"

Data ends


Code segment

        start:

                ASSUME CS:code,DS:data

                        mov ax,data
                        mov ds,ax

                        mov si,02h
                        mov cl,04h
                        mov bx,0000h

                        mov ah,09h
                        lea dx,m1
                        int 21h

                        abc:    mov ah,01h                        
                                int 21h
                                call convert


                                shl bx,cl
                                add bl,al
                                dec si
                                jnz abc
                                mov ax,bx
                                call disp

                                mov ah,4ch
                                int 21h


                            convert proc near

                                        cmp al,'9'
                                        jbe l1

                                        cmp al,'a'
                                        jb l2

                                        sub al,57h
                                        jmp l3

                                      l1: sub al,30h
                                          jmp l3

                                      l2: sub al,37h

                                      l3: ret
                           endp
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

        jbe ll1
        cmp al,0ah
        jb ll2
        add al,57h
        jmp dis
    ll1: add al,30h
        jmp dis
    ll2: add al,37h
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

Code ends

       end start
