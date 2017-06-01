data segment
m2 db 10,13,"the addition is::$"
array1 db 05,02
sum dw,0

data ends

code segment
assume cs:code,ds:data
start:mov ax,data
      mov ds,ax
        mov ah,09h
        lea dx,m2
        int 21h

        mov cl,02
        xor di,di
        lea bx,array1
  a:      mov al,[bx+di]
        mov ah,00h
        add sum,ax
        inc di
        dec cl
        jnz a
       
        


         mov ax, sum
         call display1

        mov ah,4ch
        int 21h
      
      display1 proc near
        push dx
        push ax
        push cx
           mov cl,04
           mov ch,04
        back:
           rol ax,cl
           push ax
           and al,0fh
           cmp al,'9'
           jbe add30
           add al,37h
           jmp disp
        add30: add al,30h
        disp: mov ah,02h
              mov dl,al
              int 21h
              pop ax
              dec ch
              jnz back
              pop ax
              pop dx
              ret
              endp
               
       code ends
       end start
