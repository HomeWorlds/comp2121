; This part of the code deals with initialising the program.
; in inserts the first array into sort array
; this is due to the main program dealing with iterativley sorting the next array in.	
start:	
	ldi r16, low(RAMEND-4)	
	ldi r17, high(RAMEND-4)	
	out SPL, r16	
	out SPH, r17

	ldi ZL, low(first_array<<1)
	ldi ZH, high(first_array<<1)
	ldi YL, low(sort_array<<1)
	ldi YH, high(sort_array<<1)

	ldi index, 0
	ldi size, 7

insert_initial_array:
	lpm temp, Z+
	st Y+, temp
	cp index, size
	breq initialise_new_values
	inc index
	rjmp insert_initial_array
