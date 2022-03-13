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

PUBLIC _ZX_ROM
_ZX_ROM:
;ROM version
ld bc, (_gfx_xy)        ;20 ticks
;call Plot ROM routine
	call $22e5
ret


; WORKING ROUTINES

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


;WORKS - LEAVE ALONE
;https://github.com/ibancg/zxcircle/blob/master/zxcircle.asm
PUBLIC _table_plot
_table_plot:

; keep the register BC
    push bc

    ld hl, tabpow2
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
tabpow2:
    ;; lookup table with powers of 2
    defb    128,64,32,16,8,4,2,1

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


;https://worldofspectrum.org/forums/discussion/4460/
;WORKS - LEAVE ALONE
;============================================================================
; put pixel
; d = x
; e = y
;============================================================================
PUBLIC _putpix
_putpix:
    ld de, (_gfx_xy)

    ld a,e ; 0-63 or 64-127 or 128-191
    and 11000000b
    rrca
    rrca
    rrca
    add a, $40
    ld h,a

    ld a,e ; y mod 8
    and 00000111b
    add a,h
    ld h,a

    ld a,e
    and 00111000b
    rlca
    rlca
    ld l,a

    ld a,d ; x / 8
    and 11111000b
    rrca
    rrca
    rrca
    or l
    ld l,a

    ld a,d ; bits count
    and 00000111b
    ld bc,putpix_bits
    add a,c
    ld c,a
    ld a,(bc)

    ld b,(hl)
    or b
    ld (hl),a
ret

putpix_bits: defb 128,64,32,16,8,4,2,1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;https://worldofspectrum.org/forums/discussion/37438/plot-and-draw-in-machine-code/p1
;WORKS - LEAVE ALONE
PUBLIC _AA_PLOT
_AA_PLOT:
	; enter:
	; h = pix Y 0..191
	; l = pix X 0..255
	; uses: af, b, de, hl

	push bc ; save the BC register

    ld hl, (_gfx_xy)

	ld a,l
	and $07   ; a = bit position from leftmost bit (0 = leftmost pix in byte)

	ld b,a
	ld a,$80   ; a = pixel mask starting at leftmost pixel in byte
	jr z, AA_norotate   ; if bit position is 0 we already have pixel mask

AA_rotate:   ; else rotate pixel mask right 'b' times
   rra
   djnz AA_rotate

AA_norotate:
   ld b,a   ; b = pixel mask

   call AA_PIX2SCR   ; compute hl = screen address from pixel coordinates

   ld a,b   ; get pixel mask
   or (hl)   ; OR with screen contents
   ld (hl),a   ; write to screen
   pop bc  ;restore BC
ret   ; note no change to attribute

AA_PIX2SCR:
	; enter:
	; l = pix X 0..255
	; h = pix Y 0..191
	; exit : hl = screen address
	; uses: af, d, hl

	ld a,h   ; a = y coord = BBLL LSSS
	and $07  ; a = 0000 0SSS
	or $40    ; a = 0100 0SSS
	ld d,a     ; d = 0100 0SSS
	ld a,h    ; a = y coord = BBLL LSSS
	rra
	rra
	rra       ; a = ???B BLLL
	and $18  ; a = 000B B000
	or d     ; a = 010B BSSS
	ld d,a   ; d = 010B BSSS

	srl l
	srl l
	srl l   ; l = 000C CCCC
	ld a,h   ; a = y coord = BBLL LSSS
	rla
	rla      ; a = LLLS SS??
	and $e0   ; a = LLL0 0000
	or l    ; a = LLLC CCCC

	ld l,a
	ld h,d   ; hl = 010B BSSS LLLC CCCC


ret


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

    finished:
    LD L,A  ; We establish the final "L"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;address is now in HL

    ld a,c   ; load X position
    and $07
    ;ld b,a

    ;Relative_to_Mask:
    LD B, A ; We load A (pixel position) into B
    INC B   ; We increment B (for loop passes)
    XOR A   ; A = 0
    SCF ; Set Carry Flag (A=0, CF=1)

CALC5_rotate:
    RRA     ; We rotate A to the right B times
    DJNZ CALC5_rotate

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

    pop bc
RET


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


PUBLIC _CALC55
_CALC55:
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
    ld bc,CALC55_bits
    add a,c
    ld c,a
    ld a,(bc)

    ld b,(hl)
    or b
    ld (hl),a

    pop bc
ret
CALC55_bits: defb 128,64,32,16,8,4,2,1



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

    ld bc,PIXELADD2_bits
    add a,c
    ld c,a
    ld a,(bc)

    ld b,(hl)
    or b
    ld (hl),a

    pop bc
ret
PIXELADD2_bits: defb 128,64,32,16,8,4,2,1

;http://www.zxpress.ru/article.php?id=7876
PUBLIC _dejavuPOINT
_dejavuPOINT:      ; plot e = x-axis, d = y-axis

    push bc

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
    LD DE, dejavuPOINT_bits
    ADD A,E
    LD E,A
    LD A,(DE)
    XOR (HL)
    LD (HL),A

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

    pop bc
RET
dejavuPOINT_bits: defb 128,64,32,16,8,4,2,1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    LD DE, WTF_bits
    ADD A,E
    LD E,A
    LD A,(DE)
    XOR (HL)
    LD (HL),A


    ;output to screen
    or (hl)
    ld (hl),a


RET
WTF_bits: defb 128,64,32,16,8,4,2,1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


PUBLIC _rtunes_pixel
_rtunes_pixel:

    ;PUSH BC

    ld de, (_gfx_xy)
    LD a,d
    AND A
    RRA
    SCF ; Set Carry Flag
    RRA
    AND A
    RRA
    XOR d
    AND %11111000   ;248
    XOR d
    LD H,A          ;LD D,A
    LD A,e
    RLCA
    RLCA
    RLCA
    XOR d
    AND %11000111   ;199 / $C7
    XOR d
    RLCA
    RLCA
    LD L,A

    LD A,e
    AND 7

    LD d, A

    LD DE, rtunes_bits
    ADD A,E
    LD E,A
    LD A,(DE)

    ;output to screen
    or (hl)
    ld (hl),a

    ;POP BC
RET

rtunes_bits: defb 128,64,32,16,8,4,2,1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;using DE
PUBLIC _joffa_pixel
_joffa_pixel:

    ld de, (_gfx_xy)

    ld a,d
    srl a
    srl a
    srl a
    and 0x18
    or 0x40

    ld h,a
    ld a,d
    and 7
    or h
    ld h,a

    ld a,d
    add a,a
    add a,a
    and 0xe0
    ld l,a

    ld  a,e
    srl a
    srl a
    srl a
    or l
    ld l,a					; hl = screen address.


    LD A,e
    AND 7

    LD d, A

    LD DE, joffa_bits
    ADD A,E
    LD E,A
    LD A,(DE)

    ;output to screen
    or (hl)
    ld (hl),a


ret

joffa_bits: defb 128,64,32,16,8,4,2,1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


PUBLIC _hellaPlot
_hellaPlot:          ; plot d = x-axis, e = y-axis

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

    ld l,a  ;$4f $69
    LD A, D        ;4 t
    AND 7          ;7 t

    LD DE, hella_bits
    ADD A,E
    LD E,A
    LD A,(DE)

    ;output to screen
    or (hl)
    ld (hl),a


ret

hella_bits: defb 128,64,32,16,8,4,2,1








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






