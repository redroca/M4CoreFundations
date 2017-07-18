//
//  CoreStore.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreStore.h"
#import "NSObject+JSON.h"

@interface CoreStore()

#pragma mark – Private properties
@property (nonatomic, strong) NSString              *group;
@property (nonatomic, strong) NSUserDefaults        *store;

@end

@implementation CoreStore

static NSMutableDictionary *coreStoreDictionary = nil;


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Singleton methods

+ (CoreStore *)sharedStore {
    return [self sharedStoreGroup:@"_shared_store_"];
}

+ (CoreStore *)sharedStoreGroup:(NSString *)group {
    if (coreStoreDictionary == nil) {
        @synchronized(self) {
            if (coreStoreDictionary == nil) {
                coreStoreDictionary = [[NSMutableDictionary alloc] init];
            }
        }
    }
    CoreStore *dataStore = coreStoreDictionary[group];
    if (dataStore == nil) {
        @synchronized(self) {
            if (dataStore == nil) {
                dataStore = [[CoreStore alloc] initWithGroup:group];
                [coreStoreDictionary setValue:dataStore forKey:group];
            }
        }
    }
    return dataStore;
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
    self = [super init];
    if (self) {
        _group = group;
        _store = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

#pragma mark - Public property & method

- (id)dataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    id data = [_store objectForKey:groupKey];
    return data == [NSNull null] ? nil :data;
}

- (void)setData:(id)data forKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    [_store setObject:data forKey:groupKey];
    [_store synchronize];
}

- (void)removeDataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    [_store removeObjectForKey:groupKey];
    [_store synchronize];
}

- (NSString *)stringDataForKey:(NSString *)key {
    NSString *data = (NSString *)[self dataForKey:key];
    if (data == nil) {
        return @"";
    }
    else {
        return data;
    }
}
- (void)setStringData:(NSString *)data forKey:(NSString *)key {
    if (data == nil) {
        data = @"";
    }
    
    [self setData:(NSString*)data forKey:key];
}

- (NSDate *)dateDataForKey:(NSString *)key {
    return (NSDate *)[self dataForKey:key];
}
- (void)setDateData:(NSDate *)data forKey:(NSString *)key {
    [self setData:data forKey:key];
}

- (BOOL)BOOLDataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    BOOL data = [_store boolForKey:groupKey];
    return data;
}
- (void)setBOOLData:(BOOL)data forKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    [_store setBool:data forKey:groupKey];
    [_store synchronize];
}

- (NSInteger)integerDataForKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    NSInteger data = [_store integerForKey:groupKey];
    return data;
}
- (void)setIntegerData:(NSInteger)data forKey:(NSString *)key {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    [_store setInteger:data forKey:groupKey];
    [_store synchronize];
}

- (id)jsonDataForKey:(NSString *)key type:(Class)type{
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    NSString *json = [_store stringForKey:groupKey];
    id data = nil;
    
    if (json != nil) {
        data = [type objectWithJSON:json];
    }
    
    return data;
}
- (void)setJsonData:(id)data forKey:(NSString *)key {
    NSString *json = [data getJSONString];
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    [_store setObject:json forKey:groupKey];
    [_store synchronize];
}

- (id)jsonArrayForKey:(NSString *)key type:(Class)type {
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    NSString *json = [_store stringForKey:groupKey];
    id data = nil;
    
    if (json != nil) {
        data = [type objectsWithJSONArray:json];
    }
    
    return data;
}
- (void)setJsonArrayData:(id)data forKey:(NSString *)key {
    NSString *json = [data getJSONString];
    NSString *groupKey = [NSString stringWithFormat:@"%@%@", _group, key];
    [_store setObject:json forKey:groupKey];
    [_store synchronize];
}

@end
