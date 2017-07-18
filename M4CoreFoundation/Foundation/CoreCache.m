//
//  CoreCache.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreCache.h"


@interface CoreCache()

#pragma mark – Private properties
@property (nonatomic, strong) NSString              *group;
@property (nonatomic, strong) NSMutableDictionary   *dictionary;

@end


@implementation CoreCache

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

static NSDictionary *coreCacheDictionary = nil;

#pragma mark - Singleton methods

#pragma mark - Public Method

+ (CoreCache *)sharedCache {
    return [self sharedCacheGroup:@"_shared_cache_"];
}

+ (CoreCache *)sharedCacheGroup:(NSString *)pGroup {
    
    if (coreCacheDictionary == nil) {
        @synchronized(self) {
            if (coreCacheDictionary == nil) {
                coreCacheDictionary = [[NSMutableDictionary alloc] init];
            }
        }
    }
    
    CoreCache *dataCache = coreCacheDictionary[pGroup];
    if (dataCache == nil) {
        @synchronized(self) {
            if (dataCache == nil) {
                dataCache = [[CoreCache alloc] initWithGroup:pGroup];
                [coreCacheDictionary setValue:dataCache forKey:pGroup];
            }
        }
    }
    return dataCache;
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


#pragma mark - Initialization

#pragma mark - Life Cycle

- (id)init {
    // Forbid calls to –init or +new
    NSAssert(NO, @"Cannot create instance of Singleton");
    // You can return nil or [self initSingleton] here,
    // depending on how you prefer to fail.
    return nil;
}

- (id)initWithGroup:(NSString *)group {
    if (self = [super init]) {
        _group = group;
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Public property & method

- (id)dataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    id data = _dictionary[groupKey];
    return data == [NSNull null] ? nil : data;
}

- (void)setData:(id)data forKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    if (data != nil) {
        _dictionary[groupKey] = data;
    } else {
        [_dictionary removeObjectForKey:groupKey];
    }
}

@end
