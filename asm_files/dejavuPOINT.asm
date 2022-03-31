
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;http://www.zxpress.ru/article.php?id=7876
;uses DE/HL

;5480 before optimize
;5440 after optimize
PUBLIC _dejavuPOINT
_dejavuPOINT:      ; plot e = x-axis, d = y-axis

    ld de,(_gfx_xy)
    ld b, $07
    ld a, d
    rra
    scf
    rra
    rra
    and $5F
    ld h, a
    xor e
    and b
    xor e
    rrca
    rrca
    rrca
    ld l, a
    ;here the back part of the address is made
    ;;;;;;;;;
    ld a, d
    xor h
    and b
    xor h
    ld h, a
    ;here the front part of the address is made
    ;;;;;;;;;
    ;;now we have the full address
    ld a, e
    and b
    ld de, X_PositionBits
    add a, e
    ld e, a
    ld a, (de)
    xor (hl)
    ld (hl), a

    or (hl) ; OR with screen contents
    ld (hl), a  ; write to screen
ret

;dejavuPOINT_bits: defb 128,64,32,16,8,4,2,1



PUBLIC _dejavuPOINT_backup
_dejavuPOINT_backup:      ; plot e = x-axis, d = y-axis

    ld de,(_gfx_xy) ;$5F 4B
    ld b, 0x07
    ld a, d
    rra
    scf
    rra
    rra
    and 0x5F
    ld h, a
    xor e
    and b
    xor e
    rrca
    rrca
    rrca
    ld l, a
    ;here the back part of the address is made
    ;;;;;;;;;
    ld a, d
    xor h
    and b
    xor h
    ld h, a;here the front part of the address is made
    ;;;;;;;;;
    ;;now we have the full address
    ld a, e
    and 7
    ld de, X_PositionBits
    add a, e
    ld e, a
    ld a,(de)
    xor (hl)
    ld (hl), a

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen
ret
