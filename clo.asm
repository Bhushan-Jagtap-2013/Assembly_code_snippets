code segment
        ASSUME cs:code,ds:code,es:code,ss:code

        ORG 100h

        tempAX  dw      ?
        tempBX  dw      ?
        tempCX  dw      ?
        tempDX  dw      ?
        tempDS  dw      ?
        tempES  dw      ?
        tempSI  dw      ?
        tempDI  dw      ?
        old_off      dw      ?
        old_seg      dw      ?

        BEGIN:
                jmp INIT
        TESTKEY:

                mov cs:tempAX,ax
                mov cs:tempBX,bx
                mov cs:tempCX,cx
                mov cs:tempDX,dx
                mov cs:tempDS,ds
                mov cs:tempES,es
                mov cs:tempSI,si
                mov cs:tempDI,di

                mov ah,02h
                int 1ah

                mov bx,cx

                mov ax,0B800h
                mov es,ax
                mov di,1000h

                mov cx,0604h


         back:  rol bx,cl
                mov al,bl
                and al,0fh
                add al,30h
                mov ah,97h

                mov es:[di],ax
                inc di
                inc di

                cmp ch,05
                jnz skip
                
                mov ah,97h
                mov al,':'
                mov es:[di],ax
                inc di
                inc di             


         skip:  cmp ch,03h
                jnz skip1

                mov ah,97h
                mov al,':'
                mov es:[di],ax
                inc di
                inc di
                mov bx,dx

        skip1:  dec ch
                jnz back

                mov ax,cs:tempAX
                mov bx,cs:tempBX
                mov cx,cs:tempCX
                mov dx,cs:tempDX
                mov ds,cs:tempDS
                mov es,cs:tempES
                mov si,cs:tempSI
                mov di,cs:tempDI

               ; mov ah,4ch
               ; int 21h
               jmp DWORD PTR cs:old_off

        INIT:
                mov ax,cs
                mov ds,ax

                CLI

                mov ah,35h
                mov al,08
                int 21h

                mov word ptr cs:old_seg,es
                mov word ptr cs:old_off,bx

                mov ah,25h
                mov al,08
                mov dx,offset TESTKEY
                int 21h

                mov ah,31h
                mov dx,offset INIT

                STI
                int 21h

code ends
end BEGIN
