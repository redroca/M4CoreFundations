//
//  NSString+Extension.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (NSString *)createUUID;

- (NSString *)trimmingString;

- (NSString *)MD5Hash;

- (NSString *)SHA1;

- (NSNumber *)stringToNSNumber;

- (NSString *)reverse;

- (BOOL)stringContainsSubString:(NSString *)subString;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)isNotBlank;

+ (BOOL)validateEmailWithString:(NSString*)email;

@end
