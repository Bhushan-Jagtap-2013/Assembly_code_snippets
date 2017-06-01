data segment
        m1      db      10,13,"Task switching : $"
        m2      db      10,13,"Task 1 running : $"
        m3      db      10,13,"        Task 2 running : $"
data ends
dis macro msg
        push ax
        push dx

        mov ah,09h
        lea dx,msg
        int 21h

        pop dx
        pop ax
        
endm
code segment

        ASSUME cs:code,ds:data
        start:
        mov ax,data
        mov ds,ax

        mov bx,0h
        dis m1
        call delay

        ;task1
task1:  cmp bl,09h
        je task2_rem

        dis m2
        inc bl
        mov dl,bl
        add dl,30h
        mov ah,02h
        int 21h

        mov ah,2ch
        int 21h
        mov al,dh
        mul dl
        and al,01h
        cmp al,01h
        jz task1
        jmp task2



        ;task2
task2:  cmp bh,09h
        je task1_rem

        dis m3
        inc bh
        mov dl,bh
        add dl,30h
        mov ah,02h
        int 21h

        mov ah,2ch
        int 21h
        mov al,dh
        mul dl
        and al,01h
        cmp al,01h
        jz task1
        jmp task2

        ;task1 rem
task1_rem:
        cmp bl,09h
        je exit
        dis m2
        inc bl
        mov dl,bl
        add dl,30h
        mov ah,02h
        int 21h
        jmp task1_rem

        ;task2 rem
task2_rem:
        cmp bh,09h
        je exit
        dis m3
        inc bh
        mov dl,bh
        add dl,30h
        mov ah,02h
        int 21h
        jmp task2_rem

        ;delay

exit:   mov ah,4ch
        int 21h

        delay proc near

                push ax
                push bx
                mov ax,0ffh
                
           up1: cmp ax,0h
                jz ext
                mov bx,0ffh

           up:  cmp bx,0h
                jz again
                nop
                nop
                nop
                nop
                dec bx
                jmp up

        again:  dec ax
                jmp up1

         ext:  pop bx
                pop ax
        ret
        endp

code ends
end start
