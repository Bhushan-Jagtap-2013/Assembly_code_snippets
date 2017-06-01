data segment
        noName  db      10,13,"ERROR:Enter File Name.$"
        notFnd   db      10,13,"ERROR:File not present.$$"
        handel  dw      ?
        fname   db      100 dup(0)
        buff    db      1024 dup(?)
        msg     db      10,13,"Conten of FILE :",10,13,"$"
data ends
code segment
        ASSUME cs:code,ds:data
        start:
        mov ax,data
        mov ds,ax

        ;obtain psp

        mov ah,62h
        int 21h

        mov es,bx

        ;check fname

        mov al,es:[80h]
        cmp al,00h
        jnz readF

        mov ah,09h
        lea dx,noName
        int 21h
        jmp exit

        ;read read filename

   readF:
        mov si,82h
        lea di,fname

  b:    mov al,es:[si]
        cmp al,0dh
        jz open
        mov ds:[di],al
        inc si
        inc di
        jmp b

        ;open file
   open:
        mov ah,3dh
        mov al,0h
        mov dx,offset fname
        int 21h
        jnc read

        mov ah,09h
        mov dx,offset notFnd
        int 21h
        jmp exit
        ;read file
   read:
        mov handel,ax

        mov ah,3fh
        mov bx,handel
        mov cx,1024
        mov dx,offset buff
        int 21h

        ;display

        mov cx,ax

        mov ah,09h
        mov dx,offset msg
        int 21h

        mov ah,02h
        mov di,offset buff

      up:mov dl,[di]
        inc di
        int 21h
        loop up

        ;close file
        mov ah,3eh
        mov bx,handel
        int 21h

  exit: mov ah,4ch
        int 21h

code ends
end start
