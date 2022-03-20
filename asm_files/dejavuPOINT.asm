
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;http://www.zxpress.ru/article.php?id=7876
;uses DE/HL

PUBLIC _dejavuPOINT
_dejavuPOINT:      ; plot e = x-axis, d = y-axis

    ;push bc

    LD DE,(_gfx_xy) ;$5F 4B
    LD B,0x07
    LD A,D
    RRA
    SCF
    RRA
    RRA
    AND 0x5F
    LD H,A
    XOR E
    AND B
    XOR E
    RRCA
    RRCA
    RRCA
    LD L,A;here the back part of the address is made
        ;;;;;;;;;
    LD A,D
    XOR H
    AND B
    XOR H
    LD H,A;here the front part of the address is made
        ;;;;;;;;;
    ;;now we have the full address
    LD A,E
    AND 7
    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)
    XOR (HL)
    LD (HL),A

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

    ;pop bc
RET

;dejavuPOINT_bits: defb 128,64,32,16,8,4,2,1
