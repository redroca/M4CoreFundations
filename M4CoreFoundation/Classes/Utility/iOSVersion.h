//
//  iOSVersion.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iOSVersion : NSObject

//iOS system version
+ (NSString *) getCurrentDeviceSysVer; // e.g. @"2.0" "3.2.1"

+ (BOOL) currentDeviceSysVerEqual:(NSString *) version;

+ (BOOL) currentDeviceSysVerGreater:(NSString *)version;

+ (BOOL) currentDeviceSysVerGreaterOrEqual:(NSString *)version;

+ (BOOL) currentDeviceSysVerLess:(NSString *)version;

+ (BOOL) currentDeviceSysVerLessOrEqual:(NSString *)version;

@end
