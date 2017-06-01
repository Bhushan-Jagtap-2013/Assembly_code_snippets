;Assignment No. 1
;Assignment name : Array addition
;Starting date:10/1/2012
;End date : 10/01/2012
;Roll no.:130
data segment
   array db 07h,02h
   sum dw 0
   m1 db 10,13,'Sum of array is  $'

data ends

code segment
   assume cs :code, ds :data

start :

      mov ax ,data
      mov ds,ax
      lea dx,m1
      mov ah,09h
      int 21h
      mov cl,02
      xor di,di
      lea bx,array

      a:mov al,[bx+di]
        mov ah,00h
        add sum,ax
        inc di
        dec cl
        jnz a
        mov ax,sum
        call disp
        mov ah,4ch
        int 21h

      disp proc near ;Display procedure
      push dx
      push cx
      push ax
      mov cl,04h
      mov ch,04h
      back:
          rol ax,cl
          push ax
          and al,0fh
          cmp al,09
          jbe add30
          add al,37h
          jmp disp
      add30:add al,30h
      display1:
          mov ah,02h
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

    code ends
end start
