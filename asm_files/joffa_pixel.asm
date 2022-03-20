
;using DE/HL
PUBLIC _joffa_pixel
_joffa_pixel:

    ld de, (_gfx_xy)

    ld a,d
    srl a
    srl a
    srl a
    and 0x18
    or 0x40

    ld h,a
    ld a,d
    and 7
    or h
    ld h,a

    ld a,d
    add a,a
    add a,a
    and 0xe0
    ld l,a

    ld  a,e
    srl a
    srl a
    srl a
    or l
    ld l,a					; hl = screen address.


    LD A,e
    AND 7

    LD d, A

    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)

    ;output to screen
    or (hl)
    ld (hl),a


ret

;joffa_bits: defb 128,64,32,16,8,4,2,1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;optimized by andy dansby
;using DE/HL
PUBLIC _joffa_pixel2
_joffa_pixel2:

    LD DE, (_gfx_xy)
    LD A, D

    RRCA
    RRCA
    RRCA


    AND %00011000   ;24 = 0x18
    OR  %01000000   ;64 = 0x40

    LD H, A
    LD A, D
    AND 7
    OR H
    LD H, A

    LD A, D
    ADD A, A
    ADD A, A
    AND %11100000
    LD L, A

    LD A, E

    RRCA
	RRCA
	RRCA
	AND %00011111

    OR L
    LD L,A					; hl = screen address.

    LD A,E
    AND 7

    LD D, A

    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)

    ;output to screen
    or (hl)
    ld (hl),a
ret


