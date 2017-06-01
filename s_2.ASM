
CODE SEGMENT

        ASSUME CS:CODE,DS:CODE,SS:CODE,ES:CODE
        ORG 100H  ;PSP ENDS ON FF & OUR PROG. STARTS FROM THERE

        BEGIN:
                JMP INIT
                TOLD_OFF DW ?
                TOLD_SEG DW ?
                KOLD_OFF DW ?
                KOLD_SEG DW ?

                FLG DB 0
                CNT DW 15 ;INCREASING DELAY FOR SHOWING SCREEN SAVER
                BUFF DB 4000 DUP(0) ;STORES VALUE OF SCREEN,TO PUT SCREEN SAVER

                TEMPAX DW ?                 
                TEMPCX DW ?                
                TEMPDI DW ?
                TEMPSI DW ?
                TEMPDS DW ?
                TEMPES DW ?

                TRESI:
                        CMP CS:FLG,1 ;CHECKING IF SCREEN CONTENTS ARE SAVED
                                     ;FLG=1,SAVED FLG=0 NOT SAVED

                        JZ TLAST
                        DEC CS:CNT
                        JNZ TLAST

                        MOV CS:TEMPAX,AX                        
                        MOV CS:TEMPCX,CX                        
                        MOV CS:TEMPSI,SI      ;SI=SCREEN
                        MOV CS:TEMPDI,DI      ;DI=BUFFER
                        MOV CS:TEMPDS,DS
                        MOV CS:TEMPES,ES
                        
                        MOV AX,0B800H       ;ACCESS SCREEN MEMORY
                        MOV DS,AX
                        MOV SI,00           ;STARTING OF SCREEN
                        MOV AX,CS
                        MOV ES,AX

                        MOV DI,OFFSET BUFF  ;STARTING OF BUFFER

                        MOV CX,2000  ;80*25 ,ROW*COL

                        CLD

                        REP MOVSW      ;INC DI & SI DEC CX
                        MOV AX,0B800H
                             
                        MOV ES,AX      ;MOVING VALUE INTO SCREEN
                        MOV DI,00
                        MOV AL,'Q'     ;20:ASCII VALUE OF SPACE
                        MOV AH,0C3H       ;7:IS FOR WHITE COLOR
                        MOV CX,2000

                        CLD

                        REP STOSW

                        MOV CS:FLG,1   ;VALUE IS SAVED(FLAG IS 1 AFTER TIMER)

                        MOV AX,CS:TEMPAX                       
                        MOV CX,CS:TEMPCX                       
                        MOV SI,CS:TEMPSI
                        MOV DI,CS:TEMPDI
                        MOV DS,CS:TEMPDS
                        MOV ES,CS:TEMPES

                TLAST:
                        JMP DWORD PTR CS:TOLD_OFF

                KRESI:                            ;KEYBOARD PROG. STARTED
                        CMP CS:FLG,1
                        JNZ KLAST

                        MOV CS:TEMPAX,AX                       
                        MOV CS:TEMPCX,CX                        
                        MOV CS:TEMPSI,SI
                        MOV CS:TEMPDI,DI
                        MOV CS:TEMPDS,DS
                        MOV CS:TEMPES,ES

                        MOV AX,0B800H        ;SAVING ORIGINAL CONTENTS OF SCREEN AFTER SAVED FLAG=1
                        MOV ES,AX
                        MOV DI,00            ;SCREEN
                        MOV AX,CS
                        MOV DS,AX
                        MOV SI,OFFSET BUFF  ;BUFFER                  
                        MOV CX,2000

                        CLD

                        REP MOVSW

                        MOV CS:FLG,0   ;FLAG =0 AFTER KEYBOARD

                        MOV AX,CS:TEMPAX                        
                        MOV CX,CS:TEMPCX                        
                        MOV SI,CS:TEMPSI
                        MOV DI,CS:TEMPDI
                        MOV DS,CS:TEMPDS
                        MOV ES,CS:TEMPES

                KLAST:
                        MOV CS:CNT,15
                        JMP DWORD PTR CS:KOLD_OFF

                INIT:
                        MOV AX,00
                        MOV ES,AX
                        MOV AX,CS
                        MOV DS,AX
                        MOV AH,35H  ;GET OLD ADDRESS FOR 08 & 09

                        MOV AL,08
                        INT 21H

                        MOV WORD PTR CS:TOLD_OFF,BX ;VARIABLES TO SAVE ORIGINAL 
                        MOV WORD PTR CS:TOLD_SEG,ES ;IVT ADDRESS(TIMER INTERRUPT)

                        MOV AH,35H
                        MOV AL,09
                        INT 21H


                        MOV WORD PTR CS:KOLD_OFF,BX ;VARIABLES TO SAVE ORIGINAL 
                        MOV WORD PTR CS:KOLD_SEG,ES ;IVT ADDRESS(KEYBRD INTERRUPT)

                        CLI

                        MOV AH,25H
                        MOV AL,08

                        MOV DX,OFFSET CS:TRESI
                        INT 21H

                        MOV AH,25H
                        MOV AL,09

                        MOV DX,OFFSET CS:KRESI
                        INT 21H

                        STI

                        MOV AH,31H  ;SIZE OF PROGRAM
                        MOV DX,OFFSET INIT
                        INT 21H

                        jmp tresi
CODE ENDS             
END BEGIN
