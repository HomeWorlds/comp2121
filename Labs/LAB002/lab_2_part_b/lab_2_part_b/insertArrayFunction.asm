; function to insert the array pointed to by Z into Y
insert_request:		; prologue
	push index 
	push first
	push second

	; VALUE to insert
	; Direction
	; array inserting into

end_insert_request:		; epilogue
	pop index 
	pop first
	pop second
	rcall sort_prep