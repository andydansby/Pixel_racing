
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;WORKS - LEAVE ALONE
;https://github.com/ibancg/zxcircle/blob/master/zxcircle.asm
PUBLIC _table_plot
_table_plot:

; keep the register BC
    push bc

    ld hl, X_PositionBits
    ld a, (_gfx_x)
    and 7       ; gfx_x mod 8
    ld b,0
    ld c,a
    add hl,bc
    ld a,(hl)
    ld e,a      ; e contains one bit set

    ld hl, tablinidx
    ld a, (_gfx_y)
    ld b,0
    ld c,a
    add hl,bc
    ld a,(hl)   ; table lookup

    ld h,0
    ld l,a
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl       ; x32 (16 bits)

    set 6,h         ; adds the screen start address (16384)

    ld a, (_gfx_x)
    srl a
    srl a
    srl a           ; gfx_x/8.

    or l
    ld l,a         ; + gfx_x/8.

    ld a,(hl)
    or e           ; or = superposition mode.
    ld (hl),a      ; set the pixel.

    pop bc          ; recovers BC
ret

;; -----------------------------------------------
;tabpow2:
    ;; lookup table with powers of 2
;    defb    128,64,32,16,8,4,2,1

    ;; screen lines lookup table
tablinidx:
    defb    0,8,16,24,32,40,48,56,1,9,17,25,33,41,49,57
    defb    2,10,18,26,34,42,50,58,3,11,19,27,35,43,51,59
    defb    4,12,20,28,36,44,52,60,5,13,21,29,37,45,53,61
    defb    6,14,22,30,38,46,54,62,7,15,23,31,39,47,55,63

    defb    64,72,80,88,96,104,112,120,65,73,81,89,97,105,113,121
    defb    66,74,82,90,98,106,114,122,67,75,83,91,99,107,115,123
    defb    68,76,84,92,100,108,116,124,69,77,85,93,101,109,117,125
    defb    70,78,86,94,102,110,118,126,71,79,87,95,103,111,119,127

    defb    128,136,144,152,160,168,176,184,129,137,145,153,161,169,177,185
    defb    130,138,146,154,162,170,178,186,131,139,147,155,163,171,179,187
    defb    132,140,148,156,164,172,180,188,133,141,149,157,165,173,181,189
    defb    134,142,150,158,166,174,182,190,135,143,151,159,167,175,183,191
