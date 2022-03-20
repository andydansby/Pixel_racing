;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;https://github.com/breakintoprogram/lib-spectrum/blob/master/lib/output.z80
PUBLIC _Belfield_Plot
_Belfield_Plot:
    LD bc,(_gfx_xy)
    ; B = Y pixel position
    ; C = X pixel position
    ; Returns address in HL
    Calculate_Pixel_Address:
    LD A,B ; Calculate Y2,Y1,Y0
    AND %00000111 ; Mask out unwanted bits
    OR %01000000 ; Set base address of screen
    LD H,A ; Store in H
    LD A,B ; Calculate Y7,Y6
    RRA ; Shift to position
    RRA
    RRA
    AND %00011000 ; Mask out unwanted bits
    OR H ; OR with Y2,Y1,Y0
    LD H,A ; Store in H
    LD A,B ; Calculate Y5,Y4,Y3
    RLA ; Shift to position
    RLA
    AND %11100000 ;Mask out unwanted bits
    LD L,A ; Store in L
    LD A,C ; Calculate X4,X3,X2,X1,X0
    RRA ; Shift into position
    RRA
    RRA
    AND %00011111 ; Mask out unwanted bits
    OR L ; OR with Y5,Y4,Y3
    LD L,A ; Store in L

    ;;now we have the full address
    LD A,C
    AND 7
    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)
    XOR (HL)
    LD (HL),A

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen
RET

;Belfield_bits: defb 128,64,32,16,8,4,2,1
