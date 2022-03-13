//variables
extern unsigned char gfx_x;
extern unsigned char gfx_y;
extern unsigned int gfx_xy;
extern unsigned int gfx_yx;


//routines
extern void __CALLEE__ ZX_ROM (void);
//z88dkPlotFill is built into Z88dk in the zx.h library
extern void __FASTCALL__ fastPlot1(void);
extern void __FASTCALL__ table_plot (void);
extern void __FASTCALL__ putpix(void);
extern void __FASTCALL__ AA_PLOT(void);

extern void __FASTCALL__ Get_Pixel_Address(void);
extern void __FASTCALL__ CALC5(void);

extern void __FASTCALL__ PIXELADD (void);
extern void __FASTCALL__ CALC55(void);
extern void __FASTCALL__ PIXELADD2(void);
extern void __FASTCALL__ dejavuPOINT(void);

extern void __FASTCALL__ rtunes_pixel(void);

extern void __FASTCALL__ joffa_pixel(void);

extern void __FASTCALL__ hellaPlot(void);

//meh
extern void __CALLEE__ Get_Pixel_Address2(void);
extern void __CALLEE__ plot_point(void);
extern void __CALLEE__ calculate_screen_address(void);

extern void __CALLEE__ CALC6(void);
extern void __CALLEE__ Get_Pixel_Address2(void);
extern void __CALLEE__ DM_Plot(void);



//_plotpixel2
extern void __FASTCALL__ plotpixel2(void);





