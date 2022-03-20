//variables
extern unsigned char gfx_x;
extern unsigned char gfx_y;
extern unsigned int gfx_xy;
extern unsigned int gfx_yx;

extern void __FASTCALL__ loop_tester (void);

//routines
extern void __CALLEE__ ZX_ROM (void);
extern void __CALLEE__ ZX_ROM2 (void);

//Fastcall only supports one parameter in DEHL
//L = 8 bit
//HL = 16 bit
//DEHL = 32 bit

//All need adjustment to push de/hl
//z88dkPlotFill is built into Z88dk in the zx.h library
extern void __FASTCALL__ fastPlot1(void);//uses de/hl good
extern void __FASTCALL__ table_plot (void);//uses BC/hl
extern void __FASTCALL__ putpix(void);//uses de/hl/BC
extern void __FASTCALL__ AA_PLOT(void);//uses BC/de/hl

extern void __FASTCALL__ Get_Pixel_Address(void);//uses BC/hl
extern void __FASTCALL__ CALC5(void);//uses BC/hl
extern void __FASTCALL__ CALC55(void);//uses de/hl good

extern void __FASTCALL__ PIXELADD (void);//uses BC/de/hl
extern void __FASTCALL__ PIXELADD2(void);//uses BC/de/hl

extern void __FASTCALL__ dejavuPOINT(void);//uses BC/de/hl

extern void __FASTCALL__ rtunes_pixel(void);//uses de/hl good

extern void __FASTCALL__ joffa_pixel(void);//uses de/hl good
extern void __FASTCALL__ joffa_pixel2(void);//uses de/hl good

extern void __FASTCALL__ hellaPlot(void);//uses BC/de/hl



extern void __FASTCALL__ Z00M_PLOT2(void);//uses de/hl

extern void __FASTCALL__ Belfield_Plot(void);//uses BC/hl


extern void __FASTCALL__ einar_table(void);


extern void __FASTCALL__ dmsmith(void);

//meh
extern void __CALLEE__ Get_Pixel_Address2(void);
extern void __CALLEE__ plot_point(void);
extern void __CALLEE__ calculate_screen_address(void);

extern void __CALLEE__ CALC6(void);
extern void __CALLEE__ Get_Pixel_Address2(void);
extern void __CALLEE__ DM_Plot(void);



//_plotpixel2
extern void __FASTCALL__ plotpixel2(void);





