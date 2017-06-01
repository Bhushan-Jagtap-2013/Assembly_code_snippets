.model small
.486p
dsp macro msg
        push ax
        push dx
        mov ah,09h
        lea dx,msg
        int 21h
        pop dx
        pop ax
endm
.data
        gdtr    dq      ?
        idtr    dq      ?
        ldtr    dw      ?
        tr      dw      ?
        dpmi    dw      ?,?
        msw     dw      ?
        vldtr   db      10,13,"LDTR :$"
        vgdtr   db      10,13,"GDTR :$"
        vtr     db      10,13,"TR   :$"
        vidtr   db      10,13,"IDTR :$"
        vmsw    db      10,13,"MSW  :$"
        found   db      10,13,"DMMI FOUND$"
        notFount db     10,13,"DPMI not FOUND$"
        nopm    db      10,13,"Protected mode not supported$"
        hextab  db      '0123456789ABCDEF'

.code
        mov ax,@data
        mov ds,ax

        mov ax,1687h
        int 2fh

        or ax,ax
        jz exits

        dsp notFount
        jmp exit

 exits: ;stor add n call
        dsp found
        mov dpmi[0],di
        mov dpmi[2],es

        mov es,ax
        mov ax,00h

        call dword ptr dpmi
        jnc pmode
        dsp nopm
        jmp exit


pmode:
        sgdt gdtr
        sidt idtr
        sldt ldtr
        smsw msw
        str tr

        dsp vgdtr
        mov bx,word ptr [gdtr+2]
        call cov

        mov bx,word ptr [gdtr+4]
        call cov


        mov dl,':'
        mov ah,02h
        int 21h

        mov bx,word ptr gdtr
        call cov


        dsp vidtr
        mov bx,word ptr [idtr+2]
        call cov

        mov bx,word ptr [idtr+4]
        call cov


        mov dl,':'
        mov ah,02h
        int 21h

        mov bx,word ptr idtr
        call cov

        dsp vldtr
        mov bx,word ptr ldtr
        call cov
        
        dsp vmsw
        mov bx,word ptr msw
        call cov

        dsp vtr
        mov bx,word ptr tr
        call cov


exit:  mov ah,4ch
       int 21h


cov proc near
       mov cx,4
       lea dx,hextab

 up:   mov di,bx
       and di,000fh
       mov dl,hextab[di]

       mov ah,02h
       int 21h

       shr bx,4
       loop up
       ret
endp

end
         
