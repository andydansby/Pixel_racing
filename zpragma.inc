#pragma output __MMAP = -1
// memory map is provided in file "mmap.inc"

#pragma output CRT_ORG_CODE = 32768
// main binary program start        32768

#pragma output REGISTER_SP = 0xC000
// keep stack out of top 16k        0xBFFF  attention

#pragma output CRT_STACK_SIZE = 0xFD
// stack is 243 BYTES
//attention New - changed stack size

// #pragma output CRT_ENABLE_CLOSE = 0
// don't bother closing files on exit
// #pragma output CRT_ENABLE_EIDI       = 0
// don't di on start or exit; loader does di before start
// #pragma output CRT_ON_EXIT           = 0
// jump to address 0 at exit
// 0x10001 = halt on program exit

#pragma output CLIB_MALLOC_HEAP_SIZE = 0
// no heap
#pragma output CLIB_STDIO_HEAP_SIZE = 0
// no heap for opening files

// #pragma output CLIB_FOPEN_MAX = -1
// no FILE* list
// #pragma output CLIB_OPEN_MAX = -1
// no fd table
