CODE SEGMENT

    ASSUME CS:CODE , DS:CODE , ES:CODE , SS:CODE
    ORG 100H

    START:
              JMP INIT                 ;JUMP TO INITIALISATION ROUTINE
              TEMPAX DW ?
              TEMPBX DW ?
              TEMPDX DW ?
              TEMPCX DW ?
              TEMPDI DW ?
              TEMPSI DW ?
              TEMPDS DW ?
              TEMPES DW ?
              OLD_OFF DW ?
              OLD_SEG DW ?

        TESTKEY:
                    MOV CS:TEMPAX,AX
                    MOV CS:TEMPBX,BX
                    MOV CS:TEMPCX,CX
                    MOV CS:TEMPDX,DX
                    MOV CS:TEMPDI,DI
                    MOV CS:TEMPSI,SI
                    MOV CS:TEMPDS,DS
                    MOV CS:TEMPES,ES
                    
	MOV AH,02                 ;GETTING SYSTEM TIME
                    INT 1AH
                    
	MOV AX,0B800H             ;ACCESSING SCREEN MEMORY                                              
                    MOV ES,AX		;USING ES:DI
                    MOV DI,140
                    MOV BX,CX
                    MOV CX,0604H
           BACK:
                    ROL BX,CL
                    MOV AL,BL
                    AND AL,0FH
                    ADD AL,30H
                    MOV AH,17H
                    MOV ES:[DI],AX
                    INC DI
                    INC DI
                    CMP CH,05
                    JNE SKIP
                    MOV AL,':'
                    MOV AH,57H
                    MOV ES:[DI],AX
                    INC DI
                    INC DI
           SKIP:
                    CMP CH,03
                    JNE SKIP1
                    MOV AL,':'
                    MOV AH,57H
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

                    JMP DWORD PTR CS:OLD_OFF    ;INDIRECT JUMP TO TIMER

;----------------------INITIALISATION ROUTINE--------------------------

         INIT:
                    MOV AX,CS                   ;INITIALIZATION ROUTINE
                    MOV DS,AX
                    CLI                        ;PREVENT FURTHER INTERRUPTS
                    MOV AH,35H                 ;GET ADDRESS OF INT 8
                                               ;IN ES:BX
                    MOV AL,08H
                    INT 21H

                    MOV WORD PTR CS:OLD_OFF,BX
                    MOV WORD PTR CS:OLD_SEG,ES
                    MOV AH,25H                 ;SET NEW ADDRESS

                    MOV AL,08
                    MOV DX,OFFSET TESTKEY
                    INT 21H
                    MOV AH,31H                 ;REQUEST TO STAY RESIDENT
                    MOV DX,OFFSET INIT         ;SET SIZE OF RESIDENT
                                               ;PORTION
                    STI
                    INT 21H

CODE ENDS
END START