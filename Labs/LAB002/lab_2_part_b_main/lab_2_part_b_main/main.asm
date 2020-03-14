.include "header.asm"		; File for initialising variables and data objects
.include "initialise.asm"	; File for inserting the initial array.

; now we insert new values from second_array into sort array
initialise_new_values:
	ldi ZL, low(second_array<<1)
	ldi ZH, high(second_array<<1)
	ldi size, 4
	ldi index, 0
	
insert_new_values:
	lpm temp, Z+
	rcall insert_request
	cp index, size
	breq end
	inc index
	rjmp insert_new_values



end:
	rjmp end

; Function includes list:
.include "insert_request.asm"