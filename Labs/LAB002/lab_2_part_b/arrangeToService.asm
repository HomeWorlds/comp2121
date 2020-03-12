; function to point the lift into the correct direction and arrange levels accordingly.
arrangeToServiceFunction:		; prologue
	push curr 
	push first
	push second

; Function can use Z pointer for sorted array
; function also hase direction variable and currentFloor.



endArrangeToServiceFunction:		; epilogue
	pop curr 
	pop first
	pop second
	rcall end

