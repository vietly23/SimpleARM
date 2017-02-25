.text
main:
MOV  R0,#170		R0 = AA
MOV  R1,#85			R1 = 55
MOV  R2,#255		R2 = FF
MOV  R9,#0			R9 = 0

/*Fill	R3 with AAs */

LSL  R3,R0,#8		R3 = AA00
ORR  R3,R3,R0		R3 = AAAA
LSL  R3,R3,#8		R3 = AAAA00
ORR  R3,R3,R0		R3 = AAAAAA
LSL  R3,R3,#8		R3 = AAAAAA00
ORR  R3,R3,R0		R3 = AAAAAAAA

/*Fill	r4 with FFs */

LSL  R4,R2,#8				R4 = FF00
ORR  R4,R4,R2				R4 = FFFF
LSL  R4,R4,#8				R4 = FFFF00
ORR  R4,R4,R2				R4 = FFFFFF
LSL  R4,R4,#8				R4 = FFFFFF00
ORR  R4,R4,R2				R4 = FFFFFFFF

/*Fill	R5 with 55S */

LSL  R5,R1,#8				R5 = 5500
ORR  R5,R5,R1				R5 = 5555
LSL  R5,R5,#8				R5 = 555500
ORR  R5,R5,R1				R5 = 555555
LSL  R5,R5,#8				R5 = 55555500
ORR  R5,R5,R1				R5 = 55555555

/*AND  check */

AND  R6,R3,R5				R6 = 00000000
TST  R6,R4 ;				Z = 1
ADDEQ	R9,R9,#1   		 	R9 = 1					/*Increment pass count */
AND  R6,R4,#0xFF000000		R6 = FF000000
LSL  R7,R2,#24				R7 = FF000000                  
CMP  R6,R7					Z = 1													
ADDEQ	R9,R9,#1   		 	R9 = 2					/*Increment pass count */

/*ORR  Check */

ORR  R6,R3,R5		R6 = FFFFFFFF
MOV  R0,#0			R0 = 0
TEQ  R6,#0			N = 1
ADDNE	R9,R9,#1 	R9 = 3					/*Incremnt the pass count */
ORR  R6,R5,#231		R6 = 555555F7
ADD  R7,R5,#162		R7 = 555555F7
TEQ  R7,R6
ADDEQ	R9,R9,#1 	R9 = 4					/*Incremnt the pass count */

/*ADD  check */

ADD  R6,R3,R5		R6 = FFFFFFFF
ADDS R6,R6,R3  		R6 = AAAAAAA9  C = 1
AND  R6,R6,R2		R6 = A9
TEQ  R6,#169		Z = 1														
ADDEQ	R9,R9,#1 	R9 = 5					/*Incremnt the pass count */

/*ADDC  check */

ADDC  R6,R6,#3		R6 = AC														
ADDS  R7, R4, #1    R7 = 0     C = 1
ADDC R6,R6,R7		R6 = AD														
CMP R6, #173		Z = 1														
ADDEQ	R9,R9,#1 	R9 = 6					/*Incremnt the pass count */

/*MVN  check */

MVN  R6,R3 			R6 = 55555555
CMP  R6,R5			Z =1
ADDEQ	R9,R9,#1 	R9= 7					/*Increment pass count */

/*SUB  check */

ADD R6,R0,#0xFF000000	R6 = FF000000
ADDS  R7,R0,#0x0F000000	R7 = 0F000000
SUB R8,R6,R7			R8 = F0000000
LSL R8,R8,#4			r8 = 0
CMP R0,R8
ADDEQ	R9,R9,#1 	R9= 8					/*Increment pass count */
SUBC R8,R6,R7			R8 = EFFFFFFF
SUBS R8,R8,#2			R8 = EFFFFFFD    C=0						     	
ADDC R8,R8,#0x20000000	R8 = 0FFFFFFD								        	
CMP R8, R4
ADDNE	R9,R9,#1 	R9= 9					/*Increment pass count */          

/*EOR  Check */

EOR  R7,R3,#7		R7 = AAAAAAAD
EOR  R6,R3,R7		R6 = 7
CMP  R6,#7			Z = 1
ADDEQ	R9,R9,#1 	R9= 10					/*Increment pass count */

/*RSB  check */

ADD  R7, R0, #12 ; 			R6 = 12
RSB  R6, R7, R6 ;    		R6 = 7 - 12 = -5 ,	C = 1
RSB  R8, R7, #23 ;   		R8 = 23 - 12 = 11
ADD  R6,R6,R8				R6 = 6
TEQ R6,#6																		
ADDEQ	R9,R9,#1 	R9= 11					/*Increment pass count */

/*SBC  check */

ADD  R6, R0, #0x00000015 ; 	R6 = ‭21
ADD  R7, R0, #0x00000017 ; 	R7 = 23
SUBS R8, R6, R7 ; 			R8 = -2
SBC	 R6, R7, R6 ; 			R6 = 23 - 21 - 0 = 2 
SBC	 R7, R6, #2 ; 			R7 = 2 - 2 - 0 = 0
CMP R7,R0
ADDEQ	R9,R9,#1 	R9= 12					/*Increment pass count */

/*CMN  check */

CMN R8, R6
ADDEQ	R9,R9,#1 	R9= 13					/*Increment pass count */
CMN R8,#20
ADDEQ	R9,R9,#1 	R9= 13					/*dont Increment pass count */

/*RSC  check */

RSC	 R6, R8, R6 ;			R6 = 4
RSC	 R7, R6, #12 ;			R7 = 8
CMP R7,#8
ADDEQ	R9,R9,#1 	R9= 14					/*Increment pass count */

/*BIC  Check */

BIC  R6,R3,R5		R6 = AAAAAAAA
CMP  R6,R3			Z = 1
ADDEQ	R9,R9,#1 	R9= 15					/*Increment pass count */
BIC  R6, R3, #128 ; R6 = 128
CMP  R6,#128			Z = 0
ADDEQ	R9,R9,#1 	R9= 15					/*Increment pass count */

/*Logical Shift	left	check */

MOV r7, #8																			
LSL  r6,r3,R7		R6 = AAAAAA00
SUB  r6,r3,r6		R6 = AA
CMP  r6,#170		Z = 1
ADDEQ	R9,R9,#1 	R9 = 16					/*Increment pass count */

/*; logical Shift	right check */

ADD r7, R0, #16
LSR  R6,R3,R7		AAAA
LSR  R6,R6,#16		0000
cmp  r6,#0
ADDEQ	R9,R9,#1 	R9 = 17					/*;Increment pass count*/

/*; Arithmetic Shift	right check */

ADD R6,R0,#0xF000000D	    R6 = F000000D
ASR R6, R6, #4 ;			R6 = FF000000
cmp r6,#0xFF000000																					
ADDEQ	R9,R9,#1 	R9 = 18					/*;Increment pass count*/
mov r6, #3					R6 = 3
ASR R7, R7, R6 ;			R7 = 2
cmp r7,#2
ADDEQ	R9,R9,#1 	R9 = 19					/*;Increment pass count*/

/*Rotate	right	check */

ROR  r6,r3,#1		R6 = 55555555
cmp  r6,r5			Z = 1
ADDEQ	R9,R9,#1 	R9 = 20					/*Increment pass count*/
MOV R8, #4			R8 = 4
ROR  r6,r3,R8		R6 = AAAAAAAA
cmp  r6,r3			Z = 1
ADDEQ	R9,R9,#1 	R9 = 21					/*Increment pass count*/

/*Extend	rotate */

RRX  R6,R3			55555555
CMP r6, r5
ADDCS	R9,R9,#1 	R9 = 22					/*;Increment pass count */


/*Pass counter is supposed to be 10 at the end of the program
Write the passcount to mem[252]
End of program.
*/
mov r0,#252
str r9,[r0,#0]

loop:
B loop
