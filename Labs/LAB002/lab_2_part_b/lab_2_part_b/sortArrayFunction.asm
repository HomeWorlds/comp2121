; function to sort the array pointed to by Z into Y
sortArrayFunction:		; prologue
	push curr 
	push index 
	push size
	push first
	push second

; ============== SORT ==============
ldi YL, low(sortArray)
ldi YH, high(sortArray)
ldi index, 0			; set index to 0 to begin increments
ldi size, 13 			; 13 elements in the array (max, not including removed duplicates)

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
	pop index 
	pop size
	pop first
	pop second
	rcall end