.include "m2560def.inc"

// Jonathan Abood
// Part D first

.def curr = r16			; Current value in array
.def toStore = r17		; Single value to store into array.
.def isEqual = r18		; Boolean check for 2 matching cases
.def index = r19		; index to count through the array


.dseg 
sortArray:
	.byte 8				; final location of the array + 1 unique element

.cseg
initialArray:			; Array to be inserted
	.db 1,2,5,7,8,12,20


ldi ZL, low(initialArray<<1)			
ldi ZH, high(initialArray<<1)
ldi YL, low(sortArray)
ldi YH, high(sortArray)	

; Load the array to be inserted into Z register
; Load pointer to location to store array in Y register

ldi toStore, 7			; Arbitrary number to insert
ldi index, 0			; Beginning index value

memoryPlacement:
	inc index			; increment index
	lpm curr, Z+		; move element from array in Z program memory into register
	cp toStore, curr	; Check weather the element to insert is smaller than or equal too the current array element.
	brlo insert
	breq matchCase

continuePlacement:
	st Y+, curr			; insert array element into Y pointer data memory
	cpi index, 7		; check to see if end reached. 
	brne memoryPlacement
	rjmp end

matchCase:				; if two elements match, only insert 1
	st Y+, curr
	ldi isEqual, 1
	rjmp memoryPlacement

insert:					; insert both elements in unless already done so. 
	cpi isEqual, 1
	breq continuePlacement
	ldi isEqual, 1
	st Y+, toStore
	st y+, curr
	rjmp memoryPlacement

end:					; clear registers. 
	clr r16
	clr r17
	clr r18
	clr r19
	clr r20
	clr r21
	rjmp end