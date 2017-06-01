data segment
        noFilen db      10,13,"ERROR:no file name specified.$"
        overR   db      10,13,"File Already Present.",10,13,"Overwrite??$"
        fname1  db      100 dup(0)
        fname2  db      100 dup(0)
        buff    db      1024 dup (?)
        handel1 dw      ?
        handel2 dw      ?
data ends
code segment
        ASSUME cs:code,ds:data
        start:
        mov ax,data
        mov ds,ax

        ;read PSP

        mov ah,62h
        int 21h

        mov es,bx

        ;check file name
        mov al,es:[80h]
        cmp al,0h
        jnz rf1

        mov ah,09h
        lea dx,noFileN
        int 21h
        jmp exit

        ;read f1
    rf1:
        mov di,82h
        lea si,fname1

   r1:  mov al,es:[di]
        cmp al,20h
        jz rf2
        mov ds:[si],al
        inc di
        inc si
        jmp r1

        ;read f2
   rf2: inc di
        lea si,fname2

   r2:  mov al,es:[di]
        cmp al,0dh
        jz open
        mov ds:[si],al
        inc si
        inc di
        jmp r2


        ;chck f2 presend
   open:

        mov ah,3dh
        mov al,0h
        lea dx,fname2
        int 21h

        jc create

        ;display erre

        mov ah,09h
        lea dx,overR
        int 21h

        mov ah,01h
        int 21h
        cmp al,'y'
        jnz exit

        ;create f2

 create:
        mov ah,3ch
        mov cx,0h
        lea dx,fname2
        int 21h
        mov handel2,ax

        ;open f1

        mov ah,3dh
        mov al,0h
        lea dx,fname1
        int 21h
        mov handel1,ax

        ;read f1

        mov ah,3fh
        mov bx,handel1
        mov cx,1024
        lea dx,buff
        int 21h

        ;write f2

        mov cx,ax
        mov ah,40h
        mov bx,handel2
        lea dx,buff
        int 21h

        ;close


        mov ah,0eh
        mov bx,handel1
        int 21h
        mov bx,handel2
        int 21h


  exit: mov ah,4ch
        int 21h


code ends
end start
