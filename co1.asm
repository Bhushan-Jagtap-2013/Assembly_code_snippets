xyz macro msg
        push ax
        push dx
        lea dx,msg
        mov ah,09h
        int 21h
        pop dx
        pop ax
endm
data segment
        m1      db      10,13,"Mean:$"
        m2      db      10,13,"Standerd deviavion:$"
        m3      db      10,13,"Varince:$"
        data1   dd      9.0,1.0
        c1      dw      2
        c2      dw      100
        sum     dt      0
        mean    dt      0
        variance dt      0
        sd      dt      0

data ends
code segment
        ASSUME cs:code,ds:data
        start:
        mov ax,data
        mov ds,ax
  
        xyz m1
        mov cx,05h
        mov bx,00
        finit
        fldz
   up:  fld data1[bx]
        fadd st,st(1)          
        inc bx
        dec cx
        jnz up
        fidiv c1
        fimul c2
        fbstp mean
        lea bp,mean
        call dsp


        xyz m2
        mov cx,05
        mov bx,0
        finit
     i:   fld sum
       fbld mean
        fidiv c2
        fld data1[bx]
        fsub st,st(1)
        fmul st,st
        fadd st(2),st
        fstp sum
        inc bx
        dec cx
        jnz i
        fld sum
        fsqrt
        fidiv c1

        fimul c2
        fbstp sd
        lea bp,sd
        call dsp      

        xyz m3
        fbld sd
        fidiv c2
        fmul st,st
        fimul c2
        fbstp variance
        lea bp,variance
        call dsp

        mov ah,4ch
        int 21h
        dsp proc near
                mov si,09
            u:  mov bl,byte ptr[bp+si]
                call print
                dec si
                jnz u
                mov dl,'.'
                mov ah,02h
                int 21h
                mov bl,byte ptr[bp]
                call print
        ret
        endp

        print proc near
                mov cx,0204h
            q:  rol bl,cl
                mov dl,bl
                and dl,0fh
                add dl,30h
                mov ah,02h
                int 21h
                dec ch
                jnz q
        ret
        endp

code ends
end start
