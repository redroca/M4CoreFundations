//
//  CoreNibFileCache.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreNibFileCache : NSObject

+ (CoreNibFileCache *)sharedInstance;
- (UINib *)nibWithNameKey:(NSString *)nameKey;

@end
