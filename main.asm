; Ceaser Cipher Cryptography Program
; Manuel InfoSec

	.ORIG	x3000

	LEA	R0, HELLO
	PUTS
BEGIN	AND	R1, R1, #0
	AND	R2, R2, #0
	AND	R3, R3, #0
	AND	R4, R4, #0
	AND	R5, R5, #0
	AND	R6, R6, #0
	AND	R7, R7, #0

JSRS	JSR	LOAD
	JSR	LOAD2
	JSR 	EDX
	JSR	DET
	JSR	PRINT
	JSR	CLEAR
	BR	JSRS

HELLO	.STRINGZ	"Welcome to this Caeser Cipher Encrypter/Decrypter"
CIPHER	.STRINGZ	"\nEnter the cipher:\n"
COMMAND	.STRINGZ	"\n(E)ncrypt, (D)ecrypt, or E(X)it?\n"
MESSAGE	.STRINGZ	"\nEnter your message:\n"
ASCIIZ	.FILL	#-48

EDX	ST	R7, REG
	LEA	R0, COMMAND	;ask for command
	PUTS
	GETC
	OUT
	LD	R1, ENC
	ADD	R1, R1, R0
	ST	R1, FLAG	;flag 1 for encrypt
	LD	R1, EX
	ADD	R1, R1, R0
	BRz	END		;end if X
	LEA	R3, ARRAY	;load ARRAY address
	LD	R2, NEWL
	LEA	R0, MESSAGE	;ask for message
	PUTS
INPUT	GE/TC
	OUT
	ADD	R1, R0, R2
	BRz	NEXT		;end if NewLine
	STR	R0, R3, #0
	ADD	R3, R3, #1	;increment ARRAY address
	BR	INPUT		;loop until NewLine
NEXT	LEA	R0, CIPHER	;ask for cipher
	PUTS
	AND	R1, R1, #0
CIPHIN	GETC
	OUT
	ADD	R5, R1, #0
	ADD	R4, R0, R2
	BRz	RETR		;end if enter pressed
	LD	R3, ASCIIZ
	ADD	R0, R0, R3
	LD	R3, TEN
TENS	ADD	R1, R1, R5	;multiply previous sum by 10
	ADD	R3, R3, #-1
	BRp	TENS
	ADD	R1, R1, R0		
	BR	CIPHIN
	
RETR	ST	R1, CIPHST
	LD	R7, REG
	RET

END	HALT

CIPHST	.FILL	#0		;Stores cipher
FLAG	.FILL	#0		;flag for enc or dec
REG	.FILL	#0
NEWL	.FILL	#-10		;ascii for enter
ENC	.FILL	#-68		;ascii for D
EX	.FILL	#-88		;ascii for X
TEN	.FILL	#9		;for multiplying sum by 10

EARRYAD .FILL	#0
ARRYAD	.FILL	#0

DET	ST	R7, REG
	LD	R1, FLAG
	ADD	R1, R1, #0
	BRz	DECRY
	BR	ENCRY
	
DECRY	LD	R0, CIPHST	;get negative of 2s comp cipher
	NOT	R0, R0
	ADD	R0, R0, #1
	ST	R0, CIPHST
	LEA	R1, ARRAY	;load string arrays
	LD	R2, EARRYAD
LOOPD	LD	R3, LOWER
	LDR	R5, R1, #0
	BRz	RETUR		;end if null
	ADD	R0, R5, R3	;determine uppercase or lowercase
	BRp	LOWD
	LD	R3, UPPER
	ADD	R0, R5, R3
	BRp	UPD
POSTD	STR	R5, R2, #0	;store to enc/dec array
	ADD	R1, R1, #1	;increment arrays
	ADD	R2, R2, #1
	BR	LOOPD

UPD	LD	R3, UPPER
	LD	R0, CIPHST
	ADD	R5, R5, R0
	ADD	R0, R3, R5
	BRp	POSTD
	LD	R0, WRAPD
	ADD	R5, R5, R0
	BR 	POSTD
	
LOWD	LD	R3, LOWER
	LD	R0, CIPHST
	ADD	R5, R5, R0
	ADD	R0, R3, R5
	BRp	POSTD
	LD	R0, WRAPD
	ADD	R5, R5, R0
	BR 	POSTD


ENCRY	LD	R0, CIPHST
	LEA	R1, ARRAY	;load string arrays
	LD	R2, EARRYAD
LOOP	LD	R3, LOWER
	LDR	R5, R1, #0
	BRz	RETUR		;end if null
	ADD	R0, R5, R3	;determine uppercase or lowercase
	BRp	LOW
	LD	R3, UPPER
	ADD	R0, R5, R3
	BRp	UP
POSTE	STR	R5, R2, #0	;store to enc/dec array
	ADD	R1, R1, #1	;increment arrays
	ADD	R2, R2, #1
	BR	LOOP

UP	LD	R3, UPC
	LD	R0, CIPHST
	ADD	R5, R5, R0
	ADD	R0, R3, R5
	BRnz	POSTE
	LD	R0, WRAP
	ADD	R5, R5, R0
	BR 	POSTE
	
LOW	LD	R3, LOWC
	LD	R0, CIPHST
	ADD	R5, R5, R0
	ADD	R0, R3, R5
	BRnz	POSTE
	LD	R0, WRAP
	ADD	R5, R5, R0
	BR 	POSTE

RETUR	LD	R7, REG
	RET

UPC	.FILL	#-90
LOWC	.FILL	#-122
UPPER	.FILL	#-65
LOWER	.FILL	#-96
WRAP	.FILL	#-26
WRAPD	.FILL	#26

PRINT	ST	R7, REG		;print subroutine
	LEA	R0, OMESS
	PUTS
	LEA	R1, ARRAY
	
PLOOP	LDR	R0, R1, #0
	BRz	PRINTE
	OUT
	ADD	R1, R1, #1
	BR	PLOOP		;loop until null character
PRINTE	LD	R1, FLAG
	ADD	R1, R1, #0
	BRz	PRD
	BR	PRE
PRD	LEA	R0, DMESS
	PUTS
	BR	PCONT
PRE	LEA	R0, EMESS
	PUTS
	BR	PCONT
PCONT	LD	R1, EARRYAD
DLOOP	LDR	R0, R1, #0
	BRz	RETP
	OUT
	ADD	R1, R1, #1
	BR	DLOOP

RETP	LD	R7, REG
	RET
LOAD2	ST	R7, REG
	ST	R0, EARRYAD
	LEA	R0, ARRAY
	ST	R0, ARRYAD
	BR	RETP

CLEAR	ST	R7, REG
	LEA	R1, ARRAY
	LD	R2, EARRYAD
CLOOP	AND	R0, R0, #0
	STR	R0, R1, #0
	STR	R0, R2, #0
	ADD	R1, R1, #1
	ADD	R2, R2, #1
	LDR	R0, R1, #0
	BRz	RETP
	BR	CLOOP

OMESS	.STRINGZ	"\nYour original message is:\n"
EMESS	.STRINGZ	"\nYour encrypted message is:\n"
DMESS	.STRINGZ	"\nYour decrypted message is:\n"

ARRAY	.BLKW	200							;Array for strings
REG2	.FILL	#0
LOAD	ST	R7, REG2
	LEA	R0, EARRAY
	LD	R7, REG2
	RET

EARRAY	.BLKW	200							;Array for encrypted message							
.END