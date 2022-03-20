//  zcc +zx -vn -SO3 -m -lm -clib=new main.c -o main -create-app

// using sccz80 1.99c

//https://github.com/z88dk/z88dk/wiki/Classic-GenericConsole

#define ABS(N) ((N<0)?(-N):(N))
#define abs(N) ((N<0)?(-N):(N))
#define min(a,b) (((a)<(b))?(a):(b))
#define max(a,b) (((a)>(b))?(a):(b))

#define z80_bpoke(a,b)  (*(unsigned char *)(a) = b)

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')
//this is lifted from
//https://stackoverflow.com/questions/111928/is-there-a-printf-converter-to-print-in-binary-format

#pragma printf "%f %ld %d %c"
#pragma scanf  "%f %ld %d %c"

#define CHARACTER_WIDTH 31

#define SHR3 (jz=jsr, jsr^=(jsr<<7), jsr^=(jsr>>5), jsr^=(jsr<<3),jz+jsr)

#include <arch/zx.h>
#include <math.h>
#include <float.h>
#include <stdio.h>
#include <input.h>
#include <intrinsic.h>//temp to place labels
//powerful troubleshooting tool
        //intrinsic_label(border_start);
        //intrinsic_label(border_end);

#include "externs.h"

#include "variables.h"
#include "plot.h"

#include "timer.h"
#include "routines.h"



//#include "attributes.h"

void printOptions (void);

void options1 (void)
{
    //key presses
    while (1)
    {

        if (in_key_pressed( IN_KEY_SCANCODE_q ))
		{   //SPECCY ROM
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    //asmPlot1Fill();
		    zxSpectrumROM();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_w ))
		{   //Z88DK built in
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    z88dkPlotFill();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_e ))
		{   //_fastPlot1
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    fastPlotter1();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_r ))
		{   //_table_plot
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    tablePlotFill();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_t ))
		{   //putpix_routine
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    putpix_routine ();

            timerEnd();
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_y ))
		{   //AA_PLOT
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    AA_PLOT_routine ();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_u ))
		{   //_Get_Pixel_Address
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            Get_Pixel_Address_routine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_i ))
		{//metalBrain CALC 5
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    CALC5_routine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_o ))
		{   //PIXELADD
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            PIXELADD_routine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_p ))
		{   //PIXELADD
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            CALC55_routine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_a ))
		{   //PIXELADD
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            PIXEL_ADD_2_routine();

            timerEnd();
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_s ))
		{   //PIXELADD
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            dejavuPOINT_routine();

            //printf("time MS =  %ld\n", timeDiff);
		    //forcedPause(15000);
            //pressKey ();
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_d ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    rtunes_pixelRoutine();

            timerEnd();
            waitForKey ();

            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_f ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    joffa_pixelRoutine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_g ))
		{   //_fastPlot1
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    hellaPlotter1();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_h ))
		{//more optimized Joffa routine
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    joffa_pixel2_routine();

            timerEnd();
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_j ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    z00m_routine();

            timerEnd();
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_k ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    Belfield_routine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_z ))
		{   //PIXELADD
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            Get_Pixel_Address2_routine();

            timerEnd();
            waitForKey ();
            break;
		}

////////////////////////////////
		// Currently testing

		if (in_key_pressed( IN_KEY_SCANCODE_0 ))
		{   //random pixels
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            randomPixels();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_1 ))
		{   //PIXELADD
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            DM_SMITH_routine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_2 ))
		{   //PIXELADD
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            fastBrain ();

            timerEnd();
            waitForKey ();
            break;
		}
		////////////////////////////////

		if (in_key_pressed( IN_KEY_SCANCODE_4 ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    fastBrain();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_5 ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    loop_tester_routine();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_6 ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    //Get_Pixel_Address_routine ();

            timerEnd();
            waitForKey ();
            break;
		}

		//breakintoprogram
		if (in_key_pressed( IN_KEY_SCANCODE_7 ))
		{
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    breakintoprogram();

            timerEnd();
            waitForKey ();
            break;
		}







    }//end while
}//end options1



void printOptions (void)
{
    {
        zx_cls(PAPER_WHITE | INK_BLUE);
        zx_border (2);
        printf("\x16\x01\x02");

        printf ("Welcome to the Plot tester V0.2\n");
        printf ("press a key for test\n");
        printf ("\n");

        printf ("q - ZX ROM      470-589 T-states per pixel\n");
        printf ("w - z88dk Plot  518     T-states per pixel\n");
        printf ("e - fastPlot1    164-283 T-states per pixel\n");
        printf ("r - Table Plot   292     T-states per pixel\n");
        printf ("t - PutPix       196     T-states per pixel\n");
        printf ("y - AA Plot      238-369 T-states per pixel\n");
        printf ("u - Get_Pixel_Address 204-333 T-states per\n");
        printf ("i - CALC5        215-334 T-states per pixel\n");
        printf ("o - PIXEL-ADD    201-320 T-states per pixel\n");
        printf ("p - Calc 5 w/ table 222 T-states per pixel\n");
        printf ("a - PIXEL-ADD w/ table 191 T-states per\n");
        printf ("s - dejavuPOINT w/ table 206 T-states per\n");
        printf ("d - rtunes_pixel w/ table 174 T-states per\n");
        printf ("f - joffa_pixel w/ table  198 T-states per\n");
        printf ("g - hella_plot w/ table   174 T-states per\n");
        printf ("h - Joffa Optimized       191 T-states per\n");
        printf ("j - z00m Optimized        188 T-states per\n");
        printf ("k - Belfield Optimized    ??? T-states per\n");
        //printf ("1-0 - Tester Routines, may be junk\n\n");


    }

    options1();
}


void main()
{
	__asm
	ei
	__endasm

	zx_cls(PAPER_WHITE | INK_BLUE);


    while (1)
    {
        printOptions();
    }

}

//leave blank line after


