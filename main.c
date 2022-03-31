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
		{   //SPECCY ROM    T-state
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    //asmPlot1Fill();
		    zxSpectrumROM();

            timerEnd();
            printf("210-339 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_w ))
		{   //Z88DK PLOT
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    z88dkPlotFill();

            timerEnd();
            printf("518 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_e ))
		{//metalBrain CALC 5    T-state
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    CALC5_routine();

            timerEnd();
            printf("190-309 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_r ))
		{   //PIXELADD      T-state
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            PIXELADD_routine();

            timerEnd();
            printf("166-292 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_t ))
		{   //_table_plot   T-state
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    tablePlotFill();

            timerEnd();
            printf("252 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_y ))
		{   //_fastPlot1    T-state
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    fastPlotter1();

            timerEnd();
            printf("164-283 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_u ))
		{   //joffa_pixel   T-state
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    joffa_pixelRoutine();

            timerEnd();
            printf("204 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_i ))
		{   //Belfield_Plot T-state
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    Belfield_routine();

            timerEnd();
            printf("201 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_o ))
		{   //PIXEL-ADD w/ table    T-State
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            PIXEL_ADD_2_routine();

            timerEnd();
            printf("174 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_p ))
		{   //putpix_routine        T-State
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    putpix_routine ();

            timerEnd();
            printf("191 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_a ))
		{   //Calc 5 w/ table    T-State
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            CALC55_routine();

            timerEnd();
            printf("191 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_s ))
		{   //Joffa Optimized    T-State
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    joffa_pixel2_routine();

            timerEnd();
            printf("187 T-states per pixel\n");
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_d ))
		{   //z00m plot    T-State
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    z00m_routine();

            timerEnd();
            printf("188 T-states per pixel\n");
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_f ))
		{   //dejavuPOINT   T-state
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            dejavuPOINT_routine();

            timerEnd();
            printf("177 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_g ))
		{   //_fastPlot1 / hella_plot   T-state
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    hellaPlotter1();

            timerEnd();
            printf("181 T-states per pixel\n");
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_h ))
		{   //rtunes_pixel w/ table
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    rtunes_pixelRoutine();

            timerEnd();
            printf("170 T-states per pixel\n");
            waitForKey ();

            break;
		}



		//////////////meh

        if (in_key_pressed( IN_KEY_SCANCODE_x ))
		{   //AA_PLOT
		    zx_cls(PAPER_WHITE | INK_BLUE);
		    printf("\x16\x01\x02");
		    timerStart();

		    AA_PLOT_routine ();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_c ))
		{   //_Get_Pixel_Address
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            Get_Pixel_Address_routine();

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

        printf ("Welcome to the Plot tester V0.3\n");
        printf ("press a key for test\n");
        printf ("\n");

        printf ("q - ZX ROM\n");
        printf ("w - z88dk Plot\n");
        printf ("e - CALC5\n");
        printf ("r - PIXEL-ADD\n");
        printf ("t - Table Plot\n");
        printf ("y - fastPlot1\n");
        printf ("u - joffa_pixel w/ table\n");
        printf ("i - Belfield Optimized\n");
        printf ("o - PIXEL-ADD w/ table\n");
        printf ("p - PutPix\n");
        printf ("a - Calc 5 w/ table\n");
        printf ("s - Joffa Optimized\n");
        printf ("d - z00m Optimized\n");
        printf ("f - dejavuPOINT Optimized w/ table\n");
        printf ("g - hella_plot w/ table\n");
        printf ("h - rtunes_pixel w/ table\n");

        //printf ("x - AA Plot      238-369 T-states per pixel\n");
        //printf ("c - Get_Pixel_Address 204-333 T-states per\n");

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


