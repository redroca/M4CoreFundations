//
//  ModelBaseClass+JSON.m
//  AlsTravel
//
//  Created by Benjamin on 3/1/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "ModelBaseClass+JSON.h"
#import "NSObject+JSON.h"

@implementation ModelBaseClass (JSON)

+ (id) modelWithJSON:(id) json {
    return [self objectWithJSON:json];
}

@end
