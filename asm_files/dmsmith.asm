
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;



PUBLIC _dmsmith
_dmsmith:

;create a table
SCRADDTAB    EQU $F800

GENSCRTAB:
    LD DE,16384
    LD HL,SCRADDTAB
    LD B,192

LOOP:
    LD (HL),E
    INC H
    LD (HL),D
    DEC H
    INC L
    INC D
    LD A,D
    AND 7
    JR NZ,NXTLINE
    LD A,E
    ADD A,32
    LD E,A
    JR C,NXTLINE
    LD A,D
    SUB 8
    LD D,A

NXTLINE:
    DJNZ LOOP
RET





Screen_address_table:
; $F800 - $F8BF
defb $00,$00,$00,$00,$00,$00,$00,$00; $F800
defb $20,$20,$20,$20,$20,$20,$20,$20; $F808
defb $40,$40,$40,$40,$40,$40,$40,$40; $F810
defb $60,$60,$60,$60,$60,$60,$60,$60; $F818
defb $80,$80,$80,$80,$80,$80,$80,$80; $F820
defb $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0; $F828
defb $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0; $F830
defb $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0; $F838

defb $00,$00,$00,$00,$00,$00,$00,$00; $F840
defb $20,$20,$20,$20,$20,$20,$20,$20; $F848
defb $40,$40,$40,$40,$40,$40,$40,$40; $F850
defb $60,$60,$60,$60,$60,$60,$60,$60; $F858
defb $80,$80,$80,$80,$80,$80,$80,$80; $F860
defb $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0; $F868
defb $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0; $F870
defb $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0; $F878

defb $00,$00,$00,$00,$00,$00,$00,$00; $F880
defb $20,$20,$20,$20,$20,$20,$20,$20; $F888
defb $40,$40,$40,$40,$40,$40,$40,$40; $F890
defb $60,$60,$60,$60,$60,$60,$60,$60; $F898
defb $80,$80,$80,$80,$80,$80,$80,$80; $F8A0
defb $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0; $F8A8
defb $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0; $F8B0
defb $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0; $F8B8

;$F8C0 - $F8FF
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8C0-$F8C7
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8C8-$F8CF
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8D0-$F8D7
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8D8-$F8DF
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8E0-$F8E7
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8E8-$F8EF
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8F0-$F8F7
defb $00,$00,$00,$00,$00,$00,$00,$00; $F8F8-$F8FF

; $F900 - $F93F
defb $40,$41,$42,$43,$44,$45,$46,$47; $F900
defb $40,$41,$42,$43,$44,$45,$46,$47; $F908
defb $40,$41,$42,$43,$44,$45,$46,$47; $F910
defb $40,$41,$42,$43,$44,$45,$46,$47; $F918
defb $40,$41,$42,$43,$44,$45,$46,$47; $F920
defb $40,$41,$42,$43,$44,$45,$46,$47; $F928
defb $40,$41,$42,$43,$44,$45,$46,$47; $F930
defb $40,$41,$42,$43,$44,$45,$46,$47; $F938
; $F940 - $F97F
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F940
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F948
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F950
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F958
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F960
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F968
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F970
defb $48,$49,$4a,$4b,$4c,$4d,$4e,$4f; $F978
; $F980 - $F9
defb $50,$51,$52,$53,$54,$55,$56,$57; $F980
defb $50,$51,$52,$53,$54,$55,$56,$57; $F988
defb $50,$51,$52,$53,$54,$55,$56,$57; $F990
defb $50,$51,$52,$53,$54,$55,$56,$57; $F998
defb $50,$51,$52,$53,$54,$55,$56,$57; $F9A0
defb $50,$51,$52,$53,$54,$55,$56,$57; $F9A8
defb $50,$51,$52,$53,$54,$55,$56,$57; $F9B0
defb $50,$51,$52,$53,$54,$55,$56,$57; $F9B8











