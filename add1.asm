data segment
m1 db 10,13,"Addition is:$"
array1 db 02,03
sum dw 0
data ends
code segment
assume cs:code,ds:data
start:
       mov ax,data
       mov ds,ax

       mov ah,09h
       lea dx,m1
       int 21h


       mov cl,02
       lea bx,array1
       int 21h

       xor di,di

       c:mov al,[BX+di]
         mov ah,00
         add sum,ax
         inc di
         dec cl
         jnz c

        mov ax,sum

      call disp

       mov ah,4ch
       int 21h

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

