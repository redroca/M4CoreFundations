//
//  ColorMacro.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

///////////////////////////////////////////////////////////////////////////////////////////////////

// sRGB
#define CORE_RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.00f]
#define CORE_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// HSV
#define CORE_HSVCOLOR(h,s,v)    [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1.00f]
#define CORE_HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

///////////////////////////////////////////////////////////////////////////////////////////////////
