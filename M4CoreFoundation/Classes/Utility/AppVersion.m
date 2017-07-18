//
//  AppVersion.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "AppVersion.h"

@implementation AppVersion


+ (NSString *)appVersion {
    
#ifdef DEBUG
    //Debug
    NSString *result = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]; //Build Number
#else
    //Release
    NSString *result = [NSString stringWithFormat:@"%@ - %@",
                        [AppVersion verisonNumber],
                        [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]]; //Version Number + Build Number
#endif
    return result;
    
}

+ (NSString *)verisonNumber {
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)buildingNumber {
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
}


@end
