.include "m2560def.inc"

.equ size = 4
.def index = r16
.def curr = r17


.dseg
.org 0x500
final_string: .byte 4


.cseg 
rjmp main 

initial_string: .db "abc",0

main:
	; point staack to ramend
	ldi r16, low(RAMEND-4)	; -4 to store local vars
	ldi r17, high(RAMEND-4)	
	out SPL, r16	;stack pointer low, high
	out SPH, r17

	ldi zl, low(initial_string<<1)
	ldi zh, high(initial_string<<1)
	ldi yl, low(final_string)
	ldi yh, high(final_string)
	clr index

; a loop to load the string into the stack
stackLoad:
	lpm curr, z+		; load a character in r16
	push curr 			; push the byte in temp into stack
	inc index			; increment counter
	cpi index, size-1	; if counter == length not including 0
	breq prepReversal	; go to the loop to load from stack into data mem
	rjmp stackLoad		; otherwise keep running the loop
	
; This will ensure the string abc/0 becomes cba/o and not /0cba
prepReversal:
	ldi curr, 0
	push curr	
	clr index				

stackToRamProcess:
	pop curr				; pop the value into temp
	st y+, curr				; load whatever was in temp into RAM
	inc index				; incremennt the counter
	cpi index, size			; if counter == length
	breq end				; end the program
	rjmp stackToRamProcess	; otherwise keep running the loop

end:
	rjmp end

