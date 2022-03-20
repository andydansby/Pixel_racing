;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

; not eligible because this is a ROM call
;so you must PUSH/POP BC
;ROM version

PUBLIC _ZX_ROM
_ZX_ROM:

    push bc
    ld bc, (_gfx_xy)    ;20 ticks
	;call $22AA      ;call Plot ROM routine

	call $22B0
	LD B, A
	INC B
	LD A, 1

	loop:
    RRCA        ; We rotate A to the right B times
    DJNZ loop
    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

    pop bc
ret


PUBLIC _ZX_ROM_backup
_ZX_ROM_backup:

ld bc, (_gfx_xy)    ;20 ticks
	call $22e5      ;call Plot ROM routine
ret


;;022B0h
PUBLIC _ZX_ROM2
_ZX_ROM2:
;ld a, 0
ld bc, (_gfx_xy)    ;20 ticks
	call $22b0      ;call Plot ROM routine

	;$22b0
	or (hl)
    ld (hl),a
ret

