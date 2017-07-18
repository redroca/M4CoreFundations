//
//  CoreStore.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreStore : NSObject

+ (CoreStore *)sharedStore;
+ (CoreStore *)sharedStoreGroup:(NSString *)group;

- (id)initWithGroup:(NSString *)group;

//Data
- (id)dataForKey:(NSString *)key;
- (void)setData:(id)data forKey:(NSString *)key;
- (void)removeDataForKey:(NSString *)key;

//String
- (NSString *)stringDataForKey:(NSString *)key;
- (void)setStringData:(NSString *)data forKey:(NSString *)key;

//Date
- (NSDate *)dateDataForKey:(NSString *)key;
- (void)setDateData:(NSDate *)data forKey:(NSString *)key;

//Bool
- (BOOL)BOOLDataForKey:(NSString *)key;
- (void)setBOOLData:(BOOL)data forKey:(NSString *)key;

//Integer
- (NSInteger)integerDataForKey:(NSString *)key;
- (void)setIntegerData:(NSInteger)data forKey:(NSString *)key;

//JSON
- (id)jsonDataForKey:(NSString *)key type:(Class)type;
- (void)setJsonData:(id)data forKey:(NSString *)key;

//NSArray
- (id)jsonArrayForKey:(NSString *)key type:(Class)type;
- (void)setJsonArrayData:(id)data forKey:(NSString *)key;

@end
