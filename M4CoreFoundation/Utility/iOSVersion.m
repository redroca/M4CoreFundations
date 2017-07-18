//
//  iOSVersion.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "iOSVersion.h"
#import <UIKit/UIKit.h>

@implementation iOSVersion

#define SYSTEM_VERSION_EQUAL_TO(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


+ (NSString *) getCurrentDeviceSysVer{
    return [[UIDevice currentDevice] systemVersion];
}

+ (BOOL) currentDeviceSysVerEqual:(NSString *)version{
    return SYSTEM_VERSION_EQUAL_TO(version);
}

+ (BOOL) currentDeviceSysVerGreater:(NSString *)version{
    return SYSTEM_VERSION_GREATER_THAN(version);
}

+ (BOOL) currentDeviceSysVerGreaterOrEqual:(NSString *)version{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version);
}

+ (BOOL) currentDeviceSysVerLess:(NSString *)version{
    return SYSTEM_VERSION_LESS_THAN(version);
}

+ (BOOL) currentDeviceSysVerLessOrEqual:(NSString *)version{
    return SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version);
}

@end
