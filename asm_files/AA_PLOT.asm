
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;https://worldofspectrum.org/forums/discussion/37438/plot-and-draw-in-machine-code/p1
;WORKS - LEAVE ALONE
PUBLIC _AA_PLOT
_AA_PLOT:
	; enter:
	; h = pix Y 0..191
	; l = pix X 0..255
	; uses: af, b, de, hl

	push bc ; save the BC register

    ld hl, (_gfx_xy)

	ld a,l
	and $07   ; a = bit position from leftmost bit (0 = leftmost pix in byte)

	ld b,a
	ld a,$80   ; a = pixel mask starting at leftmost pixel in byte
	jr z, AA_norotate   ; if bit position is 0 we already have pixel mask

AA_rotate:   ; else rotate pixel mask right 'b' times
   rra
   djnz AA_rotate

AA_norotate:
   ld b,a   ; b = pixel mask

   call AA_PIX2SCR   ; compute hl = screen address from pixel coordinates

   ld a,b   ; get pixel mask
   or (hl)   ; OR with screen contents
   ld (hl),a   ; write to screen
   pop bc  ;restore BC
ret   ; note no change to attribute

AA_PIX2SCR:
	; enter:
	; l = pix X 0..255
	; h = pix Y 0..191
	; exit : hl = screen address
	; uses: af, d, hl

	ld a,h   ; a = y coord = BBLL LSSS
	and $07  ; a = 0000 0SSS
	or $40    ; a = 0100 0SSS
	ld d,a     ; d = 0100 0SSS
	ld a,h    ; a = y coord = BBLL LSSS
	rra
	rra
	rra       ; a = ???B BLLL
	and $18  ; a = 000B B000
	or d     ; a = 010B BSSS
	ld d,a   ; d = 010B BSSS

	srl l
	srl l
	srl l   ; l = 000C CCCC
	ld a,h   ; a = y coord = BBLL LSSS
	rla
	rla      ; a = LLLS SS??
	and $e0   ; a = LLL0 0000
	or l    ; a = LLLC CCCC

	ld l,a
	ld h,d   ; hl = 010B BSSS LLLC CCCC
ret

