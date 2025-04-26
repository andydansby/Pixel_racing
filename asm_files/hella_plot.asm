PUBLIC _hellaPlot
_hellaPlot:	              ;  plot d = x-axis, e = y-axis
	                      ;  166 T states per pixel
	ld DE,(_gfx_xy)       ;  load xy pair
	xor A                 ;  reset a to 0 and flags to default

	ld A,E                ;  load X plot point

	rra                   ;  rotate Right ----------- divide in half
	                      ;  this could also be an RRCA
	scf                   ;  set carry flag --------- turn on Carry flag
	rra                   ;  rotate right
	or A
	rra                   ;  rotate right
	                      ;  this could also be an RRCA

	ld L,A                ;  temp store in L
	xor E
	and %11111000         ;  mask out unwanted bits
	xor E

	ld H,A                ;  store High address


	ld A,D                ;  load Y plot point
	xor L
	and %00000111         ;  mask out unwanted bits
	xor D
	rrca                  ;  must be rrca
	rrca                  ;  must be rrca
	rrca                  ;

	ld L,A
	                      ;  now we have the full address
	                      ;  now use LUT to find which bit to set
	ld A,D
	and %00000111 ; mask out unwanted bits

	                      ;  use a LUT to quickly find the bit position for the X position
	ld DE,X_PositionBits
	add A,E
	ld E,A
	ld A,(DE)

	                      ;  output to screen
	or (HL)
	ld (HL),A
ret



PUBLIC _hellaPlot_old
_hellaPlot_old:          ; plot d = x-axis, e = y-axis
    ld de, (_gfx_xy)
    ld a,7
    and d
    ld b,a
    inc b
    ld a,e

    rra
    scf
    rra
    or a
    rra

    ld l,a
    xor e
    and 248
    xor e
    ld h,a
    ld a,d
    xor l
    and 7
    xor d
    rrca
    rrca
    rrca

    ld l,a

    ld a, d
    and 7

    ld de, X_PositionBits
    add a,e
    ld e,a
    ld a,(de)

    ;output to screen
    or (hl)
    ld (hl),a
ret


;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;
;uses DE/HL/BC
PUBLIC _hellaPlot2
_hellaPlot2:          ; plot d = x-axis, e = y-axis

    ld de, (_gfx_xy)
    ld a,7
    and d
    ld b,a
    inc b
    ld a,e

    rra
    scf
    rra
    or a
    rra

    ld l,a
    xor e
    and 248
    xor e
    ld h,a
    ld a,d
    xor l
    and 7
    xor d
    rrca
    rrca
    rrca

    ld l,a  ;$4f $69


    LD A, D
    AND 7

    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)

    ;output to screen
    or (hl)
    ld (hl),a


ret

;hella_bits: defb 128,64,32,16,8,4,2,1

