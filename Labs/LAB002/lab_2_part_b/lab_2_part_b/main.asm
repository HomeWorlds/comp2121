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
rjmp insertArray

firstArray:			; first array
	.db 1,2,5,7,8,12,20
secondArray:			; second array
	.db 250,1,20,9

; call memory insert file for first array
insertArray:

.include "insertArrayFunction.asm"

sort_prep:
; Here we have the two arrays combined in data memory
; And we need to prep them for the sort function.

.include "sortArrayFunction.asm"

end:
	clr r28
	clr r16
	clr r17
	clr r18
	clr r19
	clr r20
	clr r21
	rjmp end