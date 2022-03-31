
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;https://wiki.darkbyte.sk/doku.php?id=plot
PUBLIC _Z00M_PLOT2
_Z00M_PLOT2:

    ld de, (_gfx_xy)

    ld a,d
    and a
    rra
    scf
    rra
    and a
    rra
    xor d
    and $F8
    xor d
    ld h,a
    ld a,e
    rlca
    rlca
    rlca
    xor d
    and %11000111
    xor d
    rlca
    rlca
    ld l,a
    ;HL now has the address

    ld a, e   ; load X position
    and $07
    ld de, X_PositionBits
    add a, e
    ld e, a
    ld a,(de)

    ld d,(hl)
    or d
    ld (hl),a

    ;output to screen
    or (hl)
    ld (hl),a

ret ;return from the subroutine

;z00m_bits:
;defb 128,64,32,16,8,4,2,1


