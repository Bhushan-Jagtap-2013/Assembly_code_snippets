.model small

xyz macro msg
        push ax
        push dx

        mov ah,09h
        lea dx,msg
        int 21h

        pop dx
        pop ax
endm
.data
        public buff1
        public buff2
        public buff3

        buff1   db      20,?,20 dup(0)
        buff2   db      20,?,20 dup(0)
        buff3   db      20,?,40 dup(0)
        m1      db      10,13,"Enter string:$"
        m2      db      10,13,"concat srt:$"
.code
        mov ax,@data
        mov ds,ax
        mov es,ax

        extrn strcat:far
        extrn strcmp:far
        extrn strcnt:far

        xyz m1

        mov ah,0ah

        lea dx,buff1
        int 21h

        xyz m1

        lea dx,buff2
        int 21h

        xyz m2
        ;call strcat
        ;call strcmp
        call strcnt

        mov ah,4ch
        int 21h
end
