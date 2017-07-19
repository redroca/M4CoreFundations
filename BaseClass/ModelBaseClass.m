//
//  ModelBaseClass.m
//  AlsTravel
//
//  Created by Benjamin on 3/1/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "ModelBaseClass.h"
#import "NSObject+JSON.h"

@implementation ModelBaseClass

// Coding/Copying/hash/equal

- (void) encodeWithCoder:(NSCoder *)aCoder
{ [self yy_modelEncodeWithCoder:aCoder]; }

- (id) initWithCoder:(NSCoder *)aDecoder
{ self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }

- (id) copyWithZone:(NSZone *)zone
{ return [self yy_modelCopy]; }

- (NSUInteger) hash
{ return [self yy_modelHash]; }

- (BOOL) isEqual:(id)object
{ return [self yy_modelIsEqual:object]; }

- (id)init
{ if (self = [super init]) {} return self; }

+ (NSDictionary *) modelCustomPropertyMapper
{ return @{}; }

+ (NSDictionary *) modelContainerPropertyGenericClass
{ return @{}; }

@end
