.include "m2560def.inc"

// Jonathan Abood
// Part D

.def curr = r16			; temp storage for current array value
.def index = r17		; index for comparing array size
.def first = r18		; Part of the bubble sort
.def second = r19		; ""
.def size = r20			; size value storage 

.dseg 
sortArray:
	.byte 13			; Place in data storage for combined sorted array.

.cseg
rjmp insertFirstArray

firstArray:			; first array
	.db 1,2,5,7,8,12,20
secondArray:			; second array
	.db 250,1,20,9

; Stage 1) Insert the initial array into the sortArray

insertFirstArray:
	ldi ZL, low(firstArray<<1)			
	ldi ZH, high(firstArray<<1)
	ldi YL, low(sortArray)
	ldi YH, high(sortArray)	

moveFirstToMemory:
	lpm curr, Z+
	cpi curr, 0 ;
	breq insertSecondArray
	st Y+, curr 
	rjmp moveFirstToMemory

; Stage 1) Insert the second array into the sortArray

insertSecondArray:
	ldi ZL, low(secondArray<<1)			
	ldi ZH, high(secondArray<<1)
	ldi index, 0

moveSecondToMemory:
	inc index
	lpm curr, Z+
	st Y+, curr
	cpi index, 4 
	brne moveSecondToMemory
	clr index 

; take the combined array from data storage to be sorted and replaced into storage.

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
	breq end

	; Havent finished yet, need to redo the sort for the new array.
	; Refresh values to initial positions (except size)

	ldi index, 0
	ldi YL, low(sortArray)
	ldi YH, high(sortArray)

	rjmp sort

end:
	clr r28
	clr r16
	clr r17
	clr r18
	clr r19
	clr r20
	clr r21
	rjmp end