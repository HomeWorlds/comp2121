; function to point the lift into the correct direction and arrange levels accordingly.
arrangeToServiceFunction:		; prologue
	push curr 
	push first
	push second

; Function can use Z pointer for sorted array
; function also hase direction variable and currentFloor.

jumpToSort:
	cp direction, 1
	breq sortUpwards
	rjmp sortDownwards

sortUpwards:
	; here we take all values except level and sort them ascending then descending
	lpm curr, z+
	cp curr, currentLevel
	
	brsh




	rjmp endArrangeToServiceFunction

sortDownwards:

	rjmp endArrangeToServiceFunction

endArrangeToServiceFunction:		; epilogue
	pop curr 
	pop first
	pop second
	rcall end

