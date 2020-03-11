; function to insert the array pointed to by Z into Y
insertArrayFunction:		; prologue
	push curr 
	push index 
	push size
	push first
	push second

; ============== FIRST ==============
initialiseFirst:
	ldi ZL, low(firstArray<<1)			
	ldi ZH, high(firstArray<<1)
	ldi YL, low(sortArray)
	ldi YH, high(sortArray)
	ldi index, 0
	ldi size, 7
	
moveFirstToMemory:
	cp index, size
	breq initialiseSecond
	lpm curr, Z+
	st Y+, curr 
	inc index
	rjmp moveFirstToMemory

; ============== SECOND ==============

initialiseSecond:
	ldi ZL, low(secondArray<<1)			
	ldi ZH, high(secondArray<<1)
	ldi size, 4
	ldi index, 0
	
moveSecondToMemory:
	cp index, size
	breq endInsertArrayFunction
	lpm curr, Z+
	st Y+, curr 
	inc index
	rjmp moveSecondToMemory

endInsertArrayFunction:		; epilogue
	pop curr 
	pop index 
	pop size
	pop first
	pop second
	rcall sort_prep