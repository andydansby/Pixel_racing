

;WORKS - LEAVE ALONE
; Get screen address
; B = Y pixel position
; C = X pixel position
;;;;;;;;;;;;;;;;;;;;;;;;;
;in BC B = Y  C = X
;out to HL with address and a with pixel position
;https://foro.speccy.org/viewtopic.php?f=6&t=2085&hilit=calc5&start=15
PUBLIC _PIXELADD
_PIXELADD:

    push bc ;save bc register

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

    ld a,c   ; load X position
    and $07
    ;ld b,a

    ;Relative_to_Mask:
    LD B, A ; We load A (pixel position) into B
    INC B   ; We increment B (for loop passes)
    XOR A   ; A = 0
    SCF ; Set Carry Flag (A=0, CF=1)

PIXELADD_rotate:
    RRA     ; We rotate A to the right B times
    DJNZ PIXELADD_rotate

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

    pop bc  ;restore register
RET ; return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PUBLIC _PIXELADD2
_PIXELADD2:

    push bc
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

;PIXELADD2_bits: defb 128,64,32,16,8,4,2,1
