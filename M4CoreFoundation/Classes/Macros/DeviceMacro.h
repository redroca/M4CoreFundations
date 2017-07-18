//
//  DeviceMacro.h
//  M4CLibrary
//
//  Created by hades on 2017/7/11.
//  Copyright © 2017年 Hades. All rights reserved.
//


#define SCREENWIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

///2X图尺寸乘上Ratio
#define     RATIO                       [UIScreen mainScreen].bounds.size.height / 667.f
