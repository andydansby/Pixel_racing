PUBLIC _rtunes_pixel
_rtunes_pixel:

    ld DE, (_gfx_xy)	;20 T

    LD A,D				;4 T
    AND A				;4 T
    RRA					;4 T
    SCF					;4 T
    RRA					;4 T
    AND A				;4 T
    RRA					;4 T
    XOR D				;4 T
    AND %11111000		;7 T


    XOR D				;4 T
    LD H,A				;4 T
    LD A,E				;4 T
    RLCA				;4 T
    RLCA				;4 T
    RLCA				;4 T
    XOR D				;4 T
    AND %11000111		;7 T
    XOR D				;4 T
    RLCA				;4 T
    RLCA				;4 T
    LD L,A				;4 T

    LD A,E				;4 T
    AND 7				;7 T

    LD D, A				;4 T

    LD DE, X_PositionBits	;10T
    ADD A,E				;4 T
    LD E,A				;4 T
    LD A,(DE)			;7 T

    ;output to screen
    OR (hl)				;7 T
    LD (hl),A			;7 T
RET						;10 T

;174 t STATES
;rtunes_bits: defb 128,64,32,16,8,4,2,1
