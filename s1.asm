code segment
        ASSUME cs:code,ds:code,ss:code,es:code
        org 100h

        BEGIN:
                jmp INIT

        cnt     dw      2
        flg     db      0
        tempAX  dw      ?
        tempCX  dw      ?
        tempES  dw      ?
        tempDS  dw      ?
        tempSI  dw      ?
        tempDI  dw      ?
        buff    db      2000 dup(0)
        old_toff        dw      ?
        old_tseg        dw      ?
        old_koff        dw      ?
        old_kseg        dw      ?


        Tres:
                cmp cs:flg,1
                jz Tend
                dec cs:cnt
                jnz Tend
                mov cs:tempAX,ax
                mov cs:tempCX,cx
                mov cs:tempES,es
                mov cs:tempDS,ds
                mov cs:tempSI,si
                mov cs:tempDI,di
                mov ax,0b800h
                mov ds,ax
                mov si,0
                mov ax,cs
                mov es,ax
                mov di,offset buff
                mov cx,2000
                cld
                rep movsw
                mov ax,0b800h
                mov es,ax
                mov di,0
                mov cx,2000
                mov al,'g'
                mov ah,0c3h
                cld
                rep stosw
                mov cs:flg,1
                mov ax,cs:tempAX
                mov cx,cs:tempCX
                mov es,cs:tempES
                mov ds,cs:tempDS
                mov si,cs:tempSI
                mov di,cs:tempDI
         Tend:
                jmp dword ptr cs:old_toff
        Kres:
                cmp cs:flg,1
                jnz Kend

                mov cs:tempAX,ax
                mov cs:tempCX,cx
                mov cs:tempES,es
                mov cs:tempDS,ds
                mov cs:tempSI,si
                mov cs:tempDI,di

                mov ax,0b800h
                mov es,ax
                mov di,0

                mov ax,cs
                mov ds,ax
                mov si,offset buff

                mov cx,2000

                cld
            rep movsw

                mov cs:flg,0

                mov ax,cs:tempAX
                mov cx,cs:tempCX
                mov es,cs:tempES
                mov ds,cs:tempDS
                mov si,cs:tempSI
                mov di,cs:tempDI
         Kend:
         
                mov cs:cnt,15
              
                jmp dword ptr cs:old_Koff
    INIT:
                       MOV AX,00
                        MOV ES,AX
                        MOV AX,CS
                        MOV DS,AX
                        MOV AH,35H  ;GET OLD ADDRESS FOR 08 & 09

                        MOV AL,08
                        INT 21H

                        MOV WORD PTR CS:old_toff,BX ;VARIABLES TO SAVE ORIGINAL 
                        MOV WORD PTR CS:old_tseg,ES ;IVT ADDRESS(TIMER INTERRUPT)

                        MOV AH,35H
                        MOV AL,09
                        INT 21H


                        MOV WORD PTR CS:old_koff,BX ;VARIABLES TO SAVE ORIGINAL 
                        MOV WORD PTR CS:old_kseg,ES ;IVT ADDRESS(KEYBRD INTERRUPT)

                        CLI

                        MOV AH,25H
                        MOV AL,08

                        MOV DX,OFFSET CS:TRES
                        INT 21H

                        MOV AH,25H
                        MOV AL,09

                        MOV DX,OFFSET CS:KRES
                        INT 21H

                        STI

                        MOV AH,31H  ;SIZE OF PROGRAM
                        MOV DX,OFFSET INIT
                        INT 21H


code ends
end BEGIN

