; Used registers
;
.DEF rm1 = R0 ; Binary number to be multiplicated (8bit)
.DEF rmh = R1 ; Interim storage
.DEF rm2 = R2 ; Binary number to be multiplicated with (8bit)
.DEF rml = R3 ; Result, LSB (16 Bit)
.DEF reh = R4 ; Result, MSB
.DEF rmp = R16; Multi purpose register for loading
;
.CSEG
.ORG 0000
;
	rjmp START
;
START:
	ldi rmp, 0xAA ; example binary 1010 1010
	mov rm1, rmp  ; to the first binary register
	ldi rmp, 0x55 ; example binary 0101 0101
	mov rm2, rmp  ; to the second binary register
; Here we start with the multiplication of the two binaries
; in rm1 und rm2, the result will go to reh:rel (16 Bit)
MULT8:
;
; Clear start values
	clr rmh ; clear interim storage
	clr rel ; clear result registers
	clr reh
;
; Here we start with the multiplication loop
MULT8a:
;
; Step 1: Rotate lowest bit of binary number 2 to the carriage
;		  flag (divide by 2, rotate a zero into bit 7)
;
	clc ; clear carry bit
	ror rm2 ; bit 0 to carry, bit 1 to 7 one position to
; 			  the right, carry bit to bit 7
;
; Step 2: Branch depending if a 0 or 1 has been rotated to
;		  the carry bit
	brcc MULT8b ; jump over adding, if carry has a 0
; Step 3: Add 16 bits in rmh:rml to the result, with overflow
;		  from LSB to MSB
	add rel,rm1 ; add LSB of rm1 to the result
	adc reh,rmh ; add carry and MSB od rm1
;
MULT8b:
;
; Step4: Multiply rmh:rm1 by 2 (16bits, shift left)
;
	clc ; clear carry bit
	rol rm1 ; rotate LSB left (multiply by 2)
	rol rmh ; rotate carry into MSB and MSB one left
;
; Step5: Check if there are still ones in binary 2, if
;		 yes, go on multiplicating
;
	tst rm2 ; all hits zero?
	brne MULT8a ; if not, go on in the loop
;
; End of the multiplication, result in reh: rel
;
; Endless loop
;
LOOP:
	rjmp loop