;ROLL NO:165
;BATCH  :H
;PROBLEM STATEMENT:WRITE A TSR PROGRAM IN 8086 TO IMPLEMENT REAL TIME CLOCK

CODE SEGMENT
        ASSUME  CS:CODE,DS:CODE,ES:CODE,SS:CODE
                ORG 100H

        BEGIN:
                JMP INIT     ;JUMP TO INITIALIZATION
                TEMPAX DW ?
                TEMPBX DW ?
                TEMPCX DW ?
                TEMPDX DW ?
                TEMPSI DW ?
                TEMPDI DW ?
                TEMPDS DW ?
                TEMPES DW ?
                OLD_OFF DW ?
                OLD_SEG DW ? 

        TESTKEY:
                MOV CS:TEMPAX,AX        
                MOV CS:TEMPBX,BX
                MOV CS:TEMPCX,CX
                MOV CS:TEMPDX,DX
                MOV CS:TEMPSI,SI
                MOV CS:TEMPDI,DI
                MOV CS:TEMPDS,DS
                MOV CS:TEMPES,ES

                MOV AH,02        ;GETTING SYSTEM TIME
                INT 1AH

                MOV AX,0B800H    ;ACCESSING SCREEN MEMORY USING ES:DI

                MOV ES,AX
                MOV DI,3680

                MOV BX,CX
                MOV CX,0604H

        BACK:
                ROL BX,CL
                MOV AL,BL

                AND AL,0FH
                ADD AL,30H
                MOV AH,97H       ;17H IS AN ATTRIBUTE USED FOR DISPLAYING SOMETHING ON SCREEN

                MOV ES:[DI],AX

                INC DI
                INC DI

                CMP CH,05

                JNE SKIP
                MOV AL,':'
                MOV AH,97H     ;TODISPLAY COLON

                MOV ES:[DI],AX

                INC DI
                INC DI

        SKIP:
                CMP CH,03      ;COLON IS DISPLAYED AFTER TWO DIGITS
                JNE SKIP1

                MOV AL,':'
                MOV AH,97H     ;TO DISPLAY COLON
                MOV ES:[DI],AX

                INC DI
                INC DI
                MOV BX,DX

        SKIP1:
                DEC CH
                JNZ BACK

                MOV AX,CS:TEMPAX
                MOV BX,CS:TEMPBX
                MOV CX,CS:TEMPCX
                MOV DX,CS:TEMPDX
                MOV DI,CS:TEMPDI
                MOV SI,CS:TEMPSI
                MOV DS,CS:TEMPDS
                MOV ES,CS:TEMPES

                JMP DWORD PTR CS:OLD_OFF   ;INDIRECT JUMP TO TIMER(GOTO OLD OFFSET SAVED BY 35H)

        INIT:                ;INITIALIZATION ROUTINE
                MOV AX,CS
                MOV DS,AX
                CLI
                jmp testkey

                MOV AH,35H          ;TO GET OLD CS & IP
                MOV AL,08H
                INT 21H

                MOV WORD PTR CS:OLD_OFF,BX
                MOV WORD PTR CS:OLD_SEG,ES

                MOV AH,25H          ;SET NEW ADDRESS FOR INT8 IN IVT

                MOV AL,08H          ;08 IS TIMER INTERRUPT
                MOV DX,OFFSET TESTKEY
                INT 21H

                MOV AH,31H          ;REQUEST TO STAY RESIDENT
                MOV DX,OFFSET INIT

                STI
                INT 21H

CODE ENDS
        END BEGIN
