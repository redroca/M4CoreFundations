//
//  NSObject+JSON.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

+ (id) objectWithJSON:(id) json;
+ (id) objectsWithJSONArray:(id) json;

- (NSString *) getJSONString;

@end
