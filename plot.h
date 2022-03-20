#ifndef PLOT_H
#define PLOT_H

void ZX_plot (unsigned char x, unsigned char y)
{
	//just in case you are testing a new algorithm
	/*if (x < 0)		return;
	if (x > 255)	return;
	if (y < 0)		return;
	if (y > 191)	return;*/

	*zx_pxy2saddr (x,y) |= zx_px2bitmask(x);
}

void unplot(int x, int y, unsigned char colour)
{
	unsigned char *address;

	//just in case you are testing a new algorithm
	/*if (x < 0)		return;
	if (x > 255)	return;
	if (y < 0)		return;*/
	if (y > 191)	return;

	address = zx_pxy2saddr(x,y);

	*address &= ~zx_px2bitmask(x);

	*zx_saddr2aaddr(address) = colour;
}


//works
void zxSpectrumROM (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)//176   191
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            ZX_ROM();
            //ZX_ROM2();
        }
    }
}

//works
void z88dkPlotFill (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            ZX_plot(xx,yy);
        }
    }
}

//works
void fastPlotter1 (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = xx << 8;
            //gfx_xy = gfx_xy | yy;

            gfx_xy = (xx << 8) | yy;
            fastPlot1();
        }
    }
}

//works
void tablePlotFill (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_x = xx;
            gfx_y = yy;
            table_plot();
        }
    }
}

//works
void putpix_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = xx << 8;
            //gfx_xy = gfx_xy | yy;

            gfx_xy = (xx << 8) | yy;
            putpix();
        }
    }
}


//works
void AA_PLOT_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = yy << 8;
            //gfx_xy = gfx_xy | xx;

            gfx_xy = (yy << 8) | xx;
            AA_PLOT();
        }
    }
}

//works
void Get_Pixel_Address_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = yy << 8;
            gfx_xy = gfx_xy | xx;
            Get_Pixel_Address();    //_Get_Pixel_Address
        }
    }
}

//works
void CALC5_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = yy << 8;
            //gfx_xy = gfx_xy | xx;

            gfx_xy = (yy << 8) | xx;
            CALC5();
        }
    }
}

//PIXELADD
void PIXELADD_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);

    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = yy << 8;
            //gfx_xy = gfx_xy | xx;

            gfx_xy = (yy << 8) | xx;

            PIXELADD();
        }
    }
}


//CALC55_routine
void CALC55_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);

    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = yy << 8;
            //gfx_xy = gfx_xy | xx;

            gfx_xy = (yy << 8) | xx;

            CALC55();
        }
    }
}

void PIXEL_ADD_2_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);

    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            PIXELADD2();
        }
    }
}


void z00m_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);

    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            Z00M_PLOT2();
        }
    }
}






void DM_SMITH_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);

    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = yy << 8;
            //gfx_xy = gfx_xy | xx;

            //DM_Plot();
        }
    }

    gfx_x = 75;
    gfx_y = 95;
    gfx_xy = gfx_y << 8;
    gfx_xy = gfx_xy | gfx_x;

    DM_Plot();
}

void dejavuPOINT_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);

    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            dejavuPOINT();
        }
    }
}

void Get_Pixel_Address2_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);

    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            Get_Pixel_Address2();
        }
    }
}





void fastBrain (void)
{//IN_KEY_SCANCODE_x
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {

        }
    }

    gfx_xy = gfx_y << 8;
    gfx_xy = gfx_xy | gfx_x;
    rtunes_pixel();

    gfx_xy = 0;

    gfx_xy = gfx_y << 8;
    gfx_xy = gfx_xy | gfx_x;
    AA_PLOT();


}


//https://worldofspectrum.org/forums/discussion/472/line-routine/p1
void rtunes_pixelRoutine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            rtunes_pixel();
        }
    }
}


void joffa_pixelRoutine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = yy << 8;
            //gfx_xy = gfx_xy | xx;

            gfx_xy = (yy << 8) | xx;
            joffa_pixel();
        }
    }
}

void joffa_pixel2_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = yy << 8;
            //gfx_xy = gfx_xy | xx;

            gfx_xy = (yy << 8) | xx;
            joffa_pixel2();
        }
    }

    //gfx_x = 75;
    //gfx_y = 95;
    //gfx_xy = gfx_y << 8;
    //gfx_xy = gfx_xy | gfx_x;
    //joffa_pixel2();
}

void hellaPlotter1 (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //gfx_xy = xx << 8;
            //gfx_xy = gfx_xy | yy;

            gfx_xy = (xx << 8) | yy;
            hellaPlot();
        }
    }
}

void Belfield_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            Belfield_Plot();
        }
    }
}


void einar_routine (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            gfx_xy = (yy << 8) | xx;
            einar_table();
        }
    }
}








//----------------------------------------

void randomPixels (void)
{
    for (temp = 0; temp < 1000 ; temp++)
    {
        //our random number from the macro , range is 1 to 254
        xx = (SHR3 % 254);
        //our random number from the macro , range is 1 to 191
        yy = (SHR3 % 191);

        gfx_xy = yy << 8;
        gfx_xy = gfx_xy | xx;
        joffa_pixel2();
    }
}



//non working routines

void breakintoprogram (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    /*for (yy = 0; yy < 176; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {
            //ZX_plot(xx,yy);
            gfx_x = xx;
            gfx_y = yy;
            gfx_xy = yy << 8;
            gfx_xy = gfx_xy | xx;


            ZX_ROM();
        }
    }*/
    gfx_x = 75;
    gfx_y = 95;
    gfx_xy = gfx_y << 8;
    gfx_xy = gfx_xy | gfx_x;
    Get_Pixel_Address();
}







void asmPlot2Fill (void)
{
    zx_cls(PAPER_WHITE | INK_BLACK);
    for (yy = 0; yy < 192; yy++)
    {
        for (xx = 0; xx < 255 ; xx++)
        {

        }
    }
    gfx_x = 75;
    gfx_y = 95;
}


//outside of the loop
    /*gfx_x = 75;
    gfx_y = 95;
    gfx_xy = gfx_y << 8;
    gfx_xy = gfx_xy | gfx_x;
    testPlot1();*/





#endif
//leave blank line after
