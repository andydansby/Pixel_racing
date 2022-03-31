
PUBLIC _hellaPlot
_hellaPlot:          ; plot d = x-axis, e = y-axis
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

