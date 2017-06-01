code segment
        ASSUME CS:CODE
        START:
        nop
;        int 0
        int 8
        mov ah,4ch
        int 21h
code ends
END START
