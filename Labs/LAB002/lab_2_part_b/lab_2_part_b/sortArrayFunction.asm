; function to sort the array pointed to by Z into Y
sortArrayFunction:		; prologue
	push curr 
	push first
	push second

; ============== SORT ==============

sort:
	ld first, Y+
	ld second, Y

	cp second, first	; check if second is smaller than first. (need to be swapped)
	brlo swaper
	breq remover
	rjmp sortStageTwo	; Skip if ordered correctly

swaper:		
	mov curr, second	; this will get cleared so store in temp (curr).
	st Y, first
	st -Y, curr
	adiw r28, 1			; Moves onto next value

	rjmp sortStageTwo

remover:
	mov curr, second	; this will get cleared so store in temp (curr).
	st Y, first
	st -Y, r1
	adiw r28, 1			; Moves onto next value

; Move onto next values since these are correctly sorted.

sortStageTwo:
	inc index			; Increment index
	cp index, size		; Compare it with size (have we reached it yet?)
	brlo sort

	dec size			; decrease size. (we want to perform a sort on all values once for each value in the list)

	cpi size, 0			; have we finished the process?
	breq endSortArrayFunction

	; Havent finished yet, need to redo the sort for the new array.
	; Refresh values to initial positions (except size)

	ldi index, 0
	ldi YL, low(sortArray)
	ldi YH, high(sortArray)

	rjmp sort


endSortArrayFunction:		; epilogue
	pop curr 
	pop first
	pop second
	rcall arrangeLevels


; load first array into the data mem
; take second array value by value in a loop
; inside te loop we then call insert_request to sort the value into the array
; then return final array size