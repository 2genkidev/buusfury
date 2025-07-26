// color_transforms.h
#ifndef COLOR_TRANSFORMS_H
#define COLOR_TRANSFORMS_H

typedef unsigned char LUT_Color;

// Visual effects lookup table - This maps each color in the palette to a different color.
extern const LUT_Color lut_fx_8bit[256];
extern const LUT_Color lut_fx_grayscale[256];
extern const LUT_Color lut_fx_dark0[256];
extern const LUT_Color lut_fx_dark1[256];
extern const LUT_Color lut_fx_dark2[256];
extern const LUT_Color lut_fx_red0[256];
extern const LUT_Color lut_fx_red1[256];
extern const LUT_Color lut_fx_red2[256];
extern const LUT_Color lut_fx_white0[256];
extern const LUT_Color lut_fx_white1[256];
extern const LUT_Color lut_fx_white2[256];
extern const LUT_Color lut_fx_white3[256];
extern const LUT_Color lut_fx_white4[256];
extern const LUT_Color lut_fx_white5[256];
extern const LUT_Color lut_fx_green0[256];
extern const LUT_Color lut_fx_green1[256];
extern const LUT_Color lut_fx_green2[256];
extern const LUT_Color lut_fx_green3[256];

#endif