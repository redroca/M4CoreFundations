//
//  CoreCache.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreCache : NSObject

+ (CoreCache *)sharedCache;
+ (CoreCache *)sharedCacheGroup:(NSString *)group;

- (id)initWithGroup:(NSString *)group;

//Data
- (id)dataForKey:(NSString *)key;
- (void)setData:(id)data forKey:(NSString *)key;

@end
