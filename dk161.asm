data segment
m1 db 10,13,"Enter the 4 digitno number:$"
data ends
code segment
        start:
                ASSUME CS:code,DS:data
                        mov ax,data
                        mov ds,ax

                        mov ah,09h
                        lea dx,m1
                        int 21h

                        mov si,04h
                        mov cl,04
                        mov bx,0000

                     abc:mov ah,01h
                         int 21h

                         call convert
                         shl bx,cl
                         add bl,al
                         dec si
                         jnz abc

                         mov ah,4ch
                         int 21h

          convert proc near
                        cmp al,'9'
                        jbe l1

                        cmp al,'a'
                        jb l1

                        sub al,57h
                        jmp l3

                        l1:sub al,30h
                                jmp l3
                        l2:sub al,37h
                        l3:ret
                      endp


        code ends
        end start

