//
//  NSObject+JSON.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "NSObject+JSON.h"

#import <YYModel/YYModel.h>


@implementation NSObject (JSON)

+ (id) objectWithJSON:(id) json {
    id objs = nil;
    
    if ([json isKindOfClass:[NSArray class]]) {
        objs = [NSArray yy_modelArrayWithClass:[self class] json:json];
    } else if([json isKindOfClass:[NSDictionary class]]) {
        objs = [self yy_modelWithJSON:json];
    } else if([json isKindOfClass:[NSString class]]) {
        objs = [self yy_modelWithJSON:json];
    } else if([json isKindOfClass:[NSData class]]) {
        objs = [self yy_modelWithJSON:json];
    }
    return objs;
}

+ (id) objectsWithJSONArray:(id) json {
    return [NSArray yy_modelArrayWithClass:[self class] json:json];
}

- (NSString *) getJSONString {
    return [self yy_modelToJSONString];
}


@end
