
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;WORKS - LEAVE ALONE
;https://wiki.speccy.org/programacion/ensamblador/calculo-coordenadas
; Get screen address
; B = Y pixel position
; C = X pixel position
; Returns address in HL
PUBLIC _CALC5
_CALC5:
;--------------------------------------------
    ;push bc
    ld bc, (_gfx_xy)
    ; Calculation of the upper part of the address:
    LD A,B
    AND 7   ; A = 00000SSSb
    LD H,A  ; We store it in H
    LD A,B  ; We retrieve again Y
    RRA
    RRA
    RRA     ; We rotate to obtain the third
    AND $18  ; with an AND 00011000b -> 000TT000b
    OR H    ; H = H OR A = 00000SSSb OR 000TT000b
    OR $40   ; We mix H with 01000000b (vram)
    LD H,A  ; We establish the final "H"

    ; Calculation of the lower part of the address:
    LD  A,C   ; A = X coordinate
    RRA
    RRA
    RRA     ; We rotate to obtain CCCCCb
    AND $1F  ; A = A AND 31 = 000CCCCCb
    LD L,A  ; L = 000CCCCCb
    LD A,B  ; We retrieve again Y
    RLA     ; We rotate to get NNN
    RLA
    AND $E0 ; A = A AND 11100000b
    OR L    ; L = NNNCCCCC

    finished:
    LD L,A  ; We establish the final "L"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;address is now in HL

    ld a,c   ; load X position
    and $07

    ;Relative_to_Mask:
    ld b, a ; We load A (pixel position) into B
    inc b   ; We increment B (for loop passes)
    xor a   ; A = 0
    scf ; Set Carry Flag (A=0, CF=1)

CALC5_rotate:
    rra     ; We rotate A to the right B times
    DJNZ CALC5_rotate

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

    ;pop bc
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; was 6000 ms now 5700
PUBLIC _CALC55
_CALC55:
;--------------------------------------------

;;replace bc with de
;b = d
;c = e


    ;push de

    ld de, (_gfx_xy)
    ; Calculation of the upper part of the address:
    LD A,D
    AND 7   ; A = 00000SSSb
    LD H,A  ; We store it in H
    LD A,D  ; We retrieve again Y
    RRA
    RRA
    RRA     ; We rotate to obtain the third
    AND $18  ; with an AND 00011000b -> 000TT000b
    OR H    ; H = H OR A = 00000SSSb OR 000TT000b
    OR $40   ; We mix H with 01000000b (vram)
    LD H,A  ; We establish the final "H"

    ; Calculation of the lower part of the address:
    LD  A,E   ; A = X coordinate
    RRA
    RRA
    RRA     ; We rotate to obtain CCCCCb
    AND $1F  ; A = A AND 31 = 000CCCCCb
    LD L,A  ; L = 000CCCCCb
    LD A,D  ; We retrieve again Y
    RLA     ; We rotate to get NNN
    RLA
    AND $E0 ; A = A AND 11100000b
    OR L    ; L = NNNCCCCC

    LD L,A  ; We establish the final "L"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;address is now in HL

    ld a,E   ; load X position
    and $07
    ld de,X_PositionBits
    add a,E
    ld E,a
    ld a,(de)

    ld D,(hl)
    or D
    ld (hl),a

    ;pop de
ret



;CALC55_bits: defb 128,64,32,16,8,4,2,1



PUBLIC _CALC57
_CALC57:
;--------------------------------------------
    push bc

    ld bc, (_gfx_xy)
    ; Calculation of the upper part of the address:
    LD A,B
    AND 7   ; A = 00000SSSb
    LD H,A  ; We store it in H
    LD A,B  ; We retrieve again Y
    RRA
    RRA
    RRA     ; We rotate to obtain the third
    AND $18  ; with an AND 00011000b -> 000TT000b
    OR H    ; H = H OR A = 00000SSSb OR 000TT000b
    OR $40   ; We mix H with 01000000b (vram)
    LD H,A  ; We establish the final "H"

    ; Calculation of the lower part of the address:
    LD  A,C   ; A = X coordinate
    RRA
    RRA
    RRA     ; We rotate to obtain CCCCCb
    AND $1F  ; A = A AND 31 = 000CCCCCb
    LD L,A  ; L = 000CCCCCb
    LD A,B  ; We retrieve again Y
    RLA     ; We rotate to get NNN
    RLA
    AND $E0 ; A = A AND 11100000b
    OR L    ; L = NNNCCCCC

    LD L,A  ; We establish the final "L"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;address is now in HL

    ld a,c   ; load X position
    and $07
    ld bc, X_PositionBits
    add a,c
    ld c,a
    ld a,(bc)

    ld b,(hl)
    or b
    ld (hl),a

    pop bc
ret
;CALC57_bits: defb 128,64,32,16,8,4,2,1


