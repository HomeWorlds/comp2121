; this function performs inplace sorting on a current value
; stored in temp and a pointer to sort_array stored in Y

insert_request: ;prologue
	push first
	push second
	push index
	push size

	ldi YL, low(sort_array<<1)
	ldi YH, high(sort_array<<1)
	ldi second, 0

comparison_loop:
	; temp stores current value, Y stores current array vallue
	; insert a value that is smaller but not equal to any element in the array
	; use "second" as binary to check if smaller 0 no 1 yes

	cpi second, 1
	breq end_insert

	; using pointers to sort_array and temp
	; store both in order into temp_array
	; store temp array into sort_array


end_insert_request: ;epilogue
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