; this function performs inplace sorting on a current value
; stored in temp and a pointer to sort_array stored in Y
insert_request: ;prologue
	push first
	push second
	push index
	push size
	push ZL
	push ZH

	ldi ZL, low(sort_array<<1)
	ldi ZH, high(sort_array<<1)
	ldi second, 0
	ldi index, 0
	ldi YL, low(temp_array<<1)
	ldi YH, high(temp_array<<1)

comparison_loop:
	; temp stores current value, Y stores current array vallue
	; insert a value that is smaller but not equal to any element in the array
	; use "second" as binary to check if we need to skip insert 0 no 1 yes

	cpi second, 1
	breq insert_remainder

	; using pointers to sort_array and temp
	; store both in order into temp_array
	; store temp array into sort_array

	lpm temp1, Z+
	cp temp1, temp
	breq insert_remainder

insert_remainder:
	st Y+, temp1
	ldi second, 1
	cp index, temp_size
	breq move_temp_to_sort
	inc index
	rjmp insert_remainder

move_temp_to_sort
	ldi ZL, low(temp_array<<1)
	ldi ZH, high(temp_array<<1)
	ldi YL, low(sort_array<<1)
	ldi YH, high(sort_array<<1)
	ldi index, 0

move_loop:
	lpm temp1, Z+
	st Y+, temp1
	cp index, temp_size
	breq end_insert_request
	inc index
	rjmp move_loop
	
; at the conclusion we have moved the sorted values in temp_array into sort_array
; ready for new values to be inserted

end_insert_request: ;epilogue
	pop ZH
	pop ZL
	pop size
	pop index
	pop second
	pop first
	ret

; Function name : insert_request
; Takes in pointer to sort_array as well as one value
; places value in proper location in sort_array
; does nothing if value exists in array. 
; does nothing if value is current floor level. 