SECTION code_user

PUBLIC _gfx_x
_gfx_x:
defb 0       ; coordinates


PUBLIC _gfx_y
_gfx_y:
defb 0


PUBLIC _gfx_xy
_gfx_xy:
defw 0

PUBLIC _gfx_yx
_gfx_yx:
defw 0

;;;
X_PositionBits: defb 128,64,32,16,8,4,2,1
;;;

; WORKING ROUTINES
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

include "\asm_files\zx_ROM.asm"
include "\asm_files\fastPlot1.asm"
include "\asm_files\table_plot.asm"
include "\asm_files\putpix.asm"
include "\asm_files\AA_PLOT.asm"
include "\asm_files\Get_Pixel_Address.asm"
include "\asm_files\calc5.asm"
include "\asm_files\pixel_add.asm"
include "\asm_files\dejavuPOINT.asm"
include "\asm_files\rtunes.asm"
include "\asm_files\joffa_pixel.asm"
include "\asm_files\hella_plot.asm"
include "\asm_files\z00m.asm"
include "\asm_files\belfield.asm"





include "\asm_files\dmsmith.asm"




PUBLIC _einar_table
_einar_table:

;On Entry C = xcoord, B = ycoord
    ld BC, (_gfx_xy)
    LD DE,PIXELADDRESSTBL   ; Base address of pixel address table (0-175)
    LD H,$00
    LD L,B
    ADD HL,HL               ; HL = B * 2
    ADD HL,DE               ; HL = table row address
    LD E,(HL)
    INC HL
    LD D,(HL)               ; DE = screen row address
    LD A,C
    RRA
    RRA
    RRA
    AND $1F                 ; A = C DIV 8 = Pixel byte address offset
    LD H,$00
    LD L,A
    ADD HL,DE               ; HL = screen pixel byte address
    LD A,C
    AND $07                 ; A = C MOD 8 = Pixel offset
RET

PIXELADDRESSTBL:
            defw $57A0,$56A0,$55A0,$54A0,$53A0,$52A0,$51A0,$50A0
            defw $5780,$5680,$5580,$5480,$5380,$5280,$5180,$5080
            defw $5760,$5660,$5560,$5460,$5360,$5260,$5160,$5060
            defw $5740,$5640,$5540,$5440,$5340,$5240,$5140,$5040
            defw $5720,$5620,$5520,$5420,$5320,$5220,$5120,$5020
            defw $5700,$5600,$5500,$5400,$5300,$5200,$5100,$5000
            defw $4FE0,$4EE0,$4DE0,$4CE0,$4BE0,$4AE0,$49E0,$48E0
            defw $4FC0,$4EC0,$4DC0,$4CC0,$4BC0,$4AC0,$49C0,$48C0
            defw $4FA0,$4EA0,$4DA0,$4CA0,$4BA0,$4AA0,$49A0,$48A0
            defw $4F80,$4E80,$4D80,$4C80,$4B80,$4A80,$4980,$4880
            defw $4F60,$4E60,$4D60,$4C60,$4B60,$4A60,$4960,$4860
            defw $4F40,$4E40,$4D40,$4C40,$4B40,$4A40,$4940,$4840
            defw $4F20,$4E20,$4D20,$4C20,$4B20,$4A20,$4920,$4820
            defw $4F00,$4E00,$4D00,$4C00,$4B00,$4A00,$4900,$4800
            defw $47E0,$46E0,$45E0,$44E0,$43E0,$42E0,$41E0,$40E0
            defw $47C0,$46C0,$45C0,$44C0,$43C0,$42C0,$41C0,$40C0
            defw $47A0,$46A0,$45A0,$44A0,$43A0,$42A0,$41A0,$40A0
            defw $4780,$4680,$4580,$4480,$4380,$4280,$4180,$4080
            defw $4760,$4660,$4560,$4460,$4360,$4260,$4160,$4060
            defw $4740,$4640,$4540,$4440,$4340,$4240,$4140,$4040
            defw $4720,$4620,$4520,$4420,$4320,$4220,$4120,$4020
            defw $4700,$4600,$4500,$4400,$4300,$4200,$4100,$4000


;dmsmith
;if c contains your x coord and b holds the y coord, the routine could be written as follows:
;https://worldofspectrum.org/forums/discussion/5111/

PUBLIC _DM_Plot
_DM_Plot:

    ld BC, (_gfx_xy)
    LD A,C
    AND 248
    RRCA
    RRCA
    RRCA
    LD L,B
    LD H, DM_tablinidx/256
    ADD A,(HL)
    INC H
    LD H,(HL)
    LD L,A

    LD A,C
    AND 7
    LD DE, DM_PIXELTAB
    ADD A,E
    LD E,A
    LD A,(DE)
    XOR (HL)
    LD (HL),A


RET

DM_PIXELTAB:
DEFB 128,64,32,16,8,4,2,1


DM_tablinidx:
;;32 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;1 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;2 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;3 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;4 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;5 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;6 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;7 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;8 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;9 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;10 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;11 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;12 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;13 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;14 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;15 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;16 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;17 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;18 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;19 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;20 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;21 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;22 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;23 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;24 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;25 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;26 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;27 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;28 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;29 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;30 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;31 times
defb $80,$40,$20,$10,$08,$04,$02,$01 ;32 times



PUBLIC _WTF2
_WTF2:          ; plot d = x-axis, e = y-axis
    ; plot b = y-axis   c = x-axis
    ld BC, (_gfx_xy)

    ld A, B

    AND A   ; clear carry (already clear)
    RRA     ; 0xxxxxxx
    SCF     ; set carry flag
    RRA     ; 10xxxxxx
    AND A   ; clear carry flag
    RRA     ; 010xxxxx

    XOR B   ;
    AND $F8 ; keep the top 5 bits 11111000
    XOR B   ; 010xxbbb
    LD H,A  ; transfer high byte to H.

    ; the low byte is derived from both X and Y.

    LD A,C  ; the x value 0-255.
    RLCA    ;
    RLCA    ;
    RLCA    ;
    XOR B   ; the y value
    AND $C7 ; apply mask 11000111
    XOR B   ; restore unmasked bits  xxyyyxxx
    RLCA    ; rotate to              xyyyxxxx
    RLCA    ; required position.     yyyxxxxx
    LD L,A  ; low byte to L.
    ;;;;;HL now has right address $4F69

    ld a, c     ;load X plot position
    ;;LD A,#x    (#00-FF)

    AND $7

    ;INC A;????
    rla
    rla
    rla
    add a, $CE    ;$CE        $c6+8
    ; a = $E6?

;LD A,#x    (#00-FF)
;    AND #07
;    ;INC A
;    RLA
;    RLA
;    RLA
;    ADD A,#C6+8
;    LD (NN+1),A
;NN    SET N,(HL)

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;

;Input:
; D = Y Coordinate
; E = X Coordinate
;
;Output:
; DE = Screen Address
;
PUBLIC _calculate_screen_address
_calculate_screen_address:

    ld DE, (_gfx_xy)

    ld a,d
    rla
    rla
    and 224
    or e
    ld e,a
    ld a,d
    rra
    rra
    or 128
    rra
    xor d
    and 248
    xor d
    ld d,a

    ld a,1 ;one not L
    ;ld a,c  ;load in the X coordinates
    PLOTBIT99:
    rrca
    djnz PLOTBIT99
    ld h, d
    ld l, e
    or (hl)
    ld (hl),a
ret


