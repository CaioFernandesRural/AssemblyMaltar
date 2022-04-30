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
