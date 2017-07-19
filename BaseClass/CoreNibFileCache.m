//
//  CoreNibFileCache.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreNibFileCache.h"

@interface CoreNibFileCache()

@property (atomic)           dispatch_semaphore_t cacheAccessSemaphore;
@property (atomic, strong)   NSMutableDictionary  *cachedNib;

@end


@implementation CoreNibFileCache

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cachedNib = [[NSMutableDictionary alloc] init];
        self.cacheAccessSemaphore = NULL;
        self.cacheAccessSemaphore = dispatch_semaphore_create(1);
    }
    return self;
}

+ (CoreNibFileCache *)sharedInstance {
    //singleton
    static dispatch_once_t once;
    static id instance = nil;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (UINib *)nibWithNameKey:(NSString *)nameKey {
    
    //Waiting
    dispatch_semaphore_wait(self.cacheAccessSemaphore, DISPATCH_TIME_FOREVER);
    
    //Get existing XIB file
    UINib *nib = nil;
    nib = self.cachedNib[nameKey];
    
    if (!nib) {
        //Loading XIB file
        nib = [UINib nibWithNibName:nameKey bundle:[NSBundle bundleForClass:NSClassFromString(nameKey)]];
        //Add XIB cache
        self.cachedNib[nameKey] = nib;
    }
    
    //Exit
    dispatch_semaphore_signal(self.cacheAccessSemaphore);
    
    return nib;
}

@end
