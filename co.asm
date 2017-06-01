MESSAGE MACRO MSG

        PUSH DX
        PUSH AX

        MOV AH,09H
        LEA DX,MSG
        INT 21H

        POP AX
        POP DX
ENDM


DATA SEGMENT

        M1 DB 10,13,"MEAN IS:$";
        M2 DB 10,13,"STANDARD DEVIATION:$"
        M3 DB 10,13,"VARIANCE:$"

        DATA1 DD 9.0,1.0
        SUM DT 0
        C1 DW 2
        C2 DW 100
        C3 DW 2

        MEAN     DT 0
        STDDEV   DT 0
        VARIANCE DT 0

DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE,DS:DATA

        START:
                MOV AX,DATA
                MOV DS,AX

                MESSAGE M1

                MOV CX,05
                MOV BX,00

                FINIT

                FLDZ

        L1:     FLD DATA1[BX]

                FADD ST,ST(1)
                INC BX
                DEC CX

                JNZ L1

                FIDIV C1
                FIMUL C2

                FBSTP MEAN
                LEA BP,MEAN

                CALL DISP


                MESSAGE M2
                MOV CX,05
                MOV BX,00
                FINIT
                FLD SUM

l2:                FBLD MEAN
                FIDIV C2
                FLD DATA1[BX]
                FSUB ST,ST(1)
                FMUL ST,ST 
                FADD ST(2),ST

                FSTP SUM
                INC BX
                DEC CX
                JNZ L2

                FLD SUM
                FSQRT                
                FIDIV C3

                FIMUL C2
                FBSTP STDDEV
                LEA BP,STDDEV
                CALL DISP

                MESSAGE M3
                FBLD STDDEV
                FIDIV C2
                FMUL ST,ST
                FIMUL C2
                FBSTP VARIANCE
                LEA BP,VARIANCE
                CALL DISP

                MOV AH,4CH
                INT 21H

        DISP PROC NEAR

                MOV SI,09

        S1:
                MOV BL,BYTE PTR[BP+SI]

                CALL PRINT
                DEC SI
                CMP SI,00
                JNE S1

                MOV AH,02H
                MOV DL,"."
                INT 21H

                MOV BL,BYTE PTR[BP]

                CALL PRINT

                RET
        ENDP

        PRINT PROC NEAR

                MOV CH,02
                MOV CL,04

       D1:
                ROL BL,CL
                MOV DL,BL

                AND DL,0FH
                ADD DL,30H

                MOV AH,02H
                INT 21H

                DEC CH
                CMP CH,00
                JNZ D1

                RET

       ENDP

CODE ENDS        

        END START

