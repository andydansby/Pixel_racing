
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;https://worldofspectrum.org/forums/discussion/4460/
;WORKS - LEAVE ALONE
;============================================================================
; put pixel
; d = x
; e = y
;============================================================================
PUBLIC _putpix
_putpix:
    ld de, (_gfx_xy)

    ld a,e ; 0-63 or 64-127 or 128-191
    and 11000000b
    rrca
    rrca
    rrca
    add a, $40
    ld h,a

    ld a,e ; y mod 8
    and 00000111b
    add a,h
    ld h,a

    ld a,e
    and 00111000b
    rlca
    rlca
    ld l,a

    ld a,d ; x / 8
    and 11111000b
    rrca
    rrca
    rrca
    or l
    ld l,a

    ld a,d ; bits count
    and 00000111b
    ld bc, X_PositionBits
    add a,c
    ld c,a
    ld a,(bc)

    ld b,(hl)
    or b
    ld (hl),a
ret

;putpix_bits: defb 128,64,32,16,8,4,2,1
;5700
