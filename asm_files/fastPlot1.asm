
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;



;WORKS - LEAVE ALONE
;http://www.retroprogramming.com/2014/03/plotting-mandelbrot-set-on-zx-spectrum.html
;input DE  D = X and E = Y
; output in HL
PUBLIC _fastPlot1
_fastPlot1:          ; plot d = x-axis, e = y-axis

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

check_for_address1:
    ld l,a
    ld a,1
    ;one not L, I am not certain why this works

PLOTBIT2:
    rrca
    djnz PLOTBIT2
    or (hl)
    ld (hl),a

ret
