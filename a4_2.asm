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
        extrn buff1:byte
        extrn buff2:byte
        extrn buff3:byte
        m2      db      10,13,"Equal$"
        m1      db      10,13,"not Equal$"
        m3      db      10,13,"Conut:$"
        endadd  dw      0
        curadd  dw      0
.code
        public strcmp
        public strcat
        public strcnt

        strcmp proc far

                mov ch,buff1+1
                mov cl,buff2+1
                cmp ch,cl
                jnz ntequl

                lea si,buff1+2
                lea di,buff2+2

          cm:   mov al,[si]
                mov ah,[di]

                cmp al,ah
                jnz ntequl

                inc si
                inc di

                dec cl
                jnz cm

                xyz m2
                jmp exit
       ntequl:  xyz m1
       exit:
        
        ret
        endp
        strcat proc far

                cld
                mov cl,buff1+1
                mov ch,0h

                lea si,buff1+2
                lea di,buff3+2
            rep movsb

       
                mov cl,buff2+1
                mov ch,0h


                lea si,buff2+2
           repz movsb

                mov cl,buff1+1
                add cl,buff2+1
                mov buff3+1,cl

                lea si,buff3+2
                

            up:
                mov ah,02h
                mov dl,[si]
                int 21h
                inc si
                dec cl

                jnz up

                
        ret
        endp
        strcnt proc far

                mov bl,0h

                mov cl,buff1+1
                mov ch,0h

                lea si,buff1+2
                mov curadd,si

                mov ax,si
                add ax,cx
                mov endadd,ax


          l1:   mov ch,0h
                mov cl,buff2+1
                lea di,buff2+2

          l2:   mov al,[di]
                mov ah,[si]
                cmp al,ah
                jnz l3

                inc si
                inc di

                loop l2

                inc bl

                cmp si,endadd
                jnz l1
                jz l4

          l3:   mov si,curadd
                inc si
                mov curadd,si
                cmp si,endadd
                jnz l1

          l4:   xyz m3

                mov bh,00
                mov ax,bx
                AAM
                mov bx,ax
                or bx,3030h

                mov ah,02h

                mov dl,bh
                int 21h
                mov dl,bl
                int 21h

        ret
        endp

end
