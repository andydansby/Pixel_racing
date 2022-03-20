;; Custom memory map
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; memory model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; contended   = 24000 (5DC0) to 32767 (7FFF)
;; uncontended = 32768 (8000) to 49151 (BFFF)
;; bankable    = 49152 (C000) to 65535 (FFFF)
;; bankable apply to 0, 1, 3, 4, 6
;; bank 2 for 8000 to C000 and can mess with program flow
;; banks 5, 7 are for screen flipping

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; memory model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SECTION tabxx1
;org $8100




;;-------------------------------------

SECTION UNCONTENDED
org 0x8000      ;	32768

;SECTION HIGHRAM
;org 0xD000

SECTION CONTENDED
org 24300      ;	24200 = 0x5E88

;24300 works

;;	$BFFF = 49151 is very top end of RAM that does not get banked
;;	$c000 = 49152 very bottom end of RAM that is Bankable

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sections defined
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;placing stack at 0xBFFE for FF bytes
;so stack runs for 0xBEFF to BFFE


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SECTION data_user
;;INCLUDEs are at the bottom

;SECTION code_user
; code_user is for read-only code

;SECTION bss_user
; bss_user is for zeroed ram variables

;SECTION data_user
; data_user is for initially non-zero ram variables

;SECTION smc_user
; smc_user is for self-modifying code

;SECTION rodata_user
; rodata_user is for constant data

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SECTION CODE
org __crt_org_code






section code_crt_init
section code_crt_main
section code_crt_exit
section code_crt_return
section code_crt_common

section code_driver
section code_font
section code_clib
  include "../../clib_code.inc"
section code_lib
section code_compiler
section code_user

section rodata_driver
section rodata_font
section rodata_clib
  include "../../clib_rodata.inc"
  ;;section rodata_error_strings
  ;;section rodata_error_string_end
  ;;defb 0
section rodata_lib
section rodata_compiler
section rodata_user

SECTION CODE_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SECTION DATA

IF __crt_org_data

   org __crt_org_data

ELSE

   IF __crt_model

      "DATA section address must be specified for rom models"

   ENDIF

ENDIF

defb 0

section smc_driver
section smc_font
section smc_clib
  include "../../clib_smc.inc"
section smc_lib
section smc_compiler
section smc_user

section data_driver
section data_font
section data_clib
  include "../../clib_data.inc"
  ;;section data_fcntl_stdio_heap_head
  ;;section data_fcntl_stdio_heap_body
  ;;section data_fcntl_stdio_heap_tail
  ;;section data_fcntl_fdtable_body
section data_lib
section data_compiler
section data_user

SECTION DATA_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SECTION BSS

IF __crt_org_bss

   org __crt_org_bss

ELSE

   IF __crt_model

      org -1

   ENDIF

ENDIF

defb 0

section BSS_UNINITIALIZED

section bss_driver
section bss_font
section bss_clib
  include "../../clib_bss.inc"
section bss_lib
section bss_compiler
section bss_user

SECTION BSS_END

;; end memory model ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

