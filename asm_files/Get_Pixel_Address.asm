
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;WORKS - LEAVE ALONE
; Get screen address
;  B = Y pixel position
;  C = X pixel position
; Returns address in HL
;http://www.breakintoprogram.co.uk/computers/zx-spectrum/screen-memory-layout
PUBLIC _Get_Pixel_Address
_Get_Pixel_Address:

    push bc ; save the bc register

    ld bc, (_gfx_xy)
    LD A,B              ; Calculate Y2,Y1,Y0
    AND %00000111   ;7  ; Mask out unwanted bits
    OR  %01000000   ;64 ; Set base address of screen
    LD H,A              ; Store in H
    LD A,B              ; Calculate Y7,Y6
    RRA                 ; Shift to position
    RRA
    RRA
    AND %00011000   ;24 ; Mask out unwanted bits
    OR H                ; OR with Y2,Y1,Y0
    LD H,A              ; Store in H
    LD A,B              ; Calculate Y5,Y4,Y3
    RLA                 ; Shift to position
    RLA
    AND %11100000   ;224    ; Mask out unwanted bits
    LD L,A              ; Store in L
    LD A,C              ; Calculate X4,X3,X2,X1,X0
    RRA                 ; Shift into position
    RRA
    RRA
    AND %00011111  ;31  ; Mask out unwanted bits
    OR L                ; OR with Y5,Y4,Y3
    LD L,A              ; Store in L
    ;ADDRESS IS FULLY FORMED HERE IN HL

; Finally, calculate relative pixel position:
    LD A, C   ; We retrieve the coordinate X
    AND 7   ; AND 00000111 to get pixel
    ; A = 00000DPI

    LD B, A          ; We load A (pixel position) into B
    INC B            ; We increment B (for loop passes)
    XOR A            ; A = 0
    SCF              ; Set Carry Flag (A=0, CF=1)
pix_rotate_bit_1:
    RRA              ; We rotate A to the right B times
    DJNZ pix_rotate_bit_1

    ;output to screen
    or (hl)
    ld (hl),a

    pop bc  ; recovers registers.
RET


PUBLIC _Get_Pixel_Address2
_Get_Pixel_Address2:

    ld bc, (_gfx_xy)
    LD A,B              ; Calculate Y2,Y1,Y0
    AND %00000111   ;7  ; Mask out unwanted bits
    OR %01000000    ;64 ; Set base address of screen
    LD H,A              ; Store in H
    LD A,B              ; Calculate Y7,Y6
    RRA                 ; Shift to position
    RRA
    RRA
    AND %00011000   ;24 ; Mask out unwanted bits
    OR H                ; OR with Y2,Y1,Y0
    LD H,A              ; Store in H
    LD A,B              ; Calculate Y5,Y4,Y3
    RLA                 ; Shift to position
    RLA
    AND %11100000   ;224    ; Mask out unwanted bits
    LD L,A              ; Store in L
    LD A,C              ; Calculate X4,X3,X2,X1,X0
    RRA                 ; Shift into position
    RRA
    RRA
    AND %00011111  ;31  ; Mask out unwanted bits
    OR L                ; OR with Y5,Y4,Y3
    LD L,A              ; Store in L
    ;ADDRESS IS FULLY FORMED HERE IN HL

    LD A,C
    AND 7
    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)
    XOR (HL)
    LD (HL),A

    ;output to screen
    or (hl)
    ld (hl),a
RET


