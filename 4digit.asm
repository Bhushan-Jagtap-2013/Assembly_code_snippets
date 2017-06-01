data segment
m1 db 10,13,"Enter a number:$"
m2 db 10,13,"Entered number is:$"
data ends
code segment
assume cs:code,ds:data
start:
       mov ax,data
       mov ds,ax

       mov ah,09h
       lea dx,m1
       int 21h

       call read
       mov ax,bx
       call disp

       mov ah,09h
       lea dx,m2
       int 21h

       mov ah,4ch
       int 21h


       read proc near
       mov si,04
       mov cl,04
       mov bx,00
       a:mov ah,01h
         int 21h
         call convert
         shl bx,cl
         add bl,al
         dec si
         jnz a
         ret
         endp

        convert proc near
        cmp al,'9'
        jbe l1
        cmp al,'a'
        jb l2
        sub al,57h
        jmp l3
        l1:sub al,30h
           jmp l3
        l2:sub al,37h
        l3:ret
           endp

           disp proc near
           push dx
           push ax
           push cx
           mov cl,04
           mov ch,04
           back:rol ax,cl
           push ax
           and al,0fh
           cmp al,'9'
           jbe add_30
           add al,37h
           jmp display1
           add_30:add al,30h
           display1:
                   mov ah,02h
                   mov dl,al
                   int 21h
            pop ax
            dec ch
            jnz back
            pop cx
            pop ax
            pop dx
            ret
            endp
           code ends
           end start

