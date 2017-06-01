dmsg macro msg
        push ax
        push dx

        mov ah,09h
        lea dx,msg
        int 21h

        pop dx
        pop ax
endm

data segment
        A       db      0
        B       db      0
        anw     dw      0
        m1      db      10,13,"Enter num1 : $"
        m2      db      10,13,"Enter num2 : $"
        m3      db      10,13,"Multiplication : $"
data ends
code segment
        ASSUME cs:code,ds:data
        start:
        mov ax,data
        mov ds,ax
        dmsg m1
        call read
        mov A,bl
        dmsg m2
        call read
        mov B,bl

        dmsg m3
        call s_a

        dmsg m3
        call a_s

        mov ah,4ch
        int 21h

        a_s proc near
                mov al,A
                mov ah,0
                mov bl,B
                mov cx,0008h
                mov dx,0h

           up3: shl dx,1
                rol bl,1
                jnc skip
                add dx,ax
          skip: loop up3

                mov ax,dx
                call disp
        ret
        endp
        s_a proc near
                mov al,A
                mov cl,B
                mov ah,0h
                mov ch,0h
                mov dx,0h
            up1: add dx,ax
                loop up1
                mov ax,dx
                call disp
        ret
        endp
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
