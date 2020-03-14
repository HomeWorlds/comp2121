; Group B Jonathan Abood Sam Obrien
.include "m2560def.inc"

.def temp = r16			; temp storage for current array value
.def index = r17		; index for comparing array size
.def first = r18		; Part of the bubble sort
.def second = r19		; ""
.def size = r20			; size value storage 
.def direction = r8		; direction of the lift ;; FOR PART C
.def current_level = r9	; the current level		;; FOR PART C
.def return_value = r10	; return value from a called function
.def temp1 = r11		; second temporary value
.def temp_size = r12	; increasing size

; sort_array : contains the final sorted array for all values needed.
.dseg 
sort_array:
	.byte 20	
	
temp_array:
	.byte 20			

; first_array: contains the initial array to be places in sort_array. 
; second_array: contains the next array, to be iterativley inserted into sort_array.
.cseg
rjmp start
first_array:			
	.db 1,2,5,7,8,12,20
second_array:			
	.db 250,1,20,9