Data segment
        m1      db      10,13,"Enter digit:$"
        m2      db      10,13,"Entered Number is:$"
Data ends
Code segment

        ASSUME cs:Code,ds:Data
        start:
        mov ax,Data
        mov ds,ax

        mov ax,05a5h
        call disp

        mov ah,4ch
        int 21h


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
Code ends
end start
