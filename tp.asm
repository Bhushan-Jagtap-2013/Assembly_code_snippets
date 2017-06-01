data segment
        data1 dd 1.0,9.0
data ends
code segment
        ASSUME ds:data,cs:code,
        start:
                mov ax,data
                mov ds,ax
                mov bx,00h
                mov cx,05h
              u:les dx,data1[bx]
                inc bx
                dec cx
                jnz u
                mov ah,4ch
                int 21h
code ends
end start
