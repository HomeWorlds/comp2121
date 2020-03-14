.include "m2560def.inc"

// Jonathan Abood
// Part D

.def curr = r16			; temp storage for current array value
.def index = r17		; index for comparing array size
.def first = r18		; Part of the bubble sort
.def second = r19		; ""
.def size = r20			; size value storage 
.def direction = r8		; direction of the lift
.def currentLevel = r9	; the current level

.dseg 
sortArray:
	.byte 13			; Place in data storage for combined sorted array.

.cseg
rjmp insertArray

firstArray:			; first array
	.db 1,2,5,7,8,12,20
secondArray:			; second array
	.db 250,1,20,9

; call memory insert file for first array
insertArray:
	ldi r16, low(RAMEND-4)	; -4 to store local vars
	ldi r17, high(RAMEND-4)	
	out SPL, r16	;stack pointer low, high
	out SPH, r17

	ldi ZL, low(firstArray<<1)
	ldi ZH, high(firstArray<<1)
	ldi YL, low(sortArray<<1)
	ldi YH, high(sortArray<<1)

	ldi index, 0
	ldi size, 7

loadFirst:
	lpm curr, z+
	st Y+, curr
	cp index, size
	breq insertNew
	inc index
	rjmp loadFirst

insertNew:
	ldi size, 4
	ldi index, 0
	ldi ZL, low(secondArray<<1)
	ldi ZH, high(secondArray<<1)

insertLoop:
	lpm curr, Z+

	.include "insert_request.asm"
	; return array size

	cp index, size
	breq sort_prep
	inc index
	rjmp insertLoop


; ========== insert array ==========

sort_prep:
	; Here we have the two arrays combined in data memory
	; And we need to prep them for the sort function.
	ldi YL, low(sortArray)
	ldi YH, high(sortArray)
	ldi index, 0			; set index to 0 to begin increments
	ldi size, 13 			; 13 elements in the array (max, not including removed duplicates)

.include "sortArrayFunction.asm"

arrangeLevels:
	; Load the sorted array into Z register pair
	ldi ZL, low(sortArray)
	ldi ZH, high(sortArray)
	ldi direction, 1		; directions : 1 = ascending, 0 = descending
	ldi currentLevel, 5
	ldi index, 0			; set index to 0 to begin increments
	ldi size, 13 			; 13 elements in the array (max, not including removed duplicates)

.include "arrangeToService.asm"

end:
	clr r8
	clr r9
	clr r28
	clr r16
	clr r17
	clr r18
	clr r19
	clr r20
	clr r21
	rjmp end