Data segment
        arr1    db      1,2,3,4
        msg1    db      "Sum is:$"
        sum     dw      0
Data ends
Code segment

        ASSUME cs:Code,ds:Data
        start:
        mov ax,Data
        mov ds,ax

        mov ah,09h
        lea dx,msg1
        int 21h

        mov cl,04
        lea bx,arr1
        xor di,di
   back:mav al,[bx+di]
        mov ah,00h
        add sum,ax
        inc di
        dec cl
        jnz back
        mov ax,sum

        mov ah,4ch
        int 21h

Code ends
end start
