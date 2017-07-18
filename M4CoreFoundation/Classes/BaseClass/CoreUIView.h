//
//  CoreUIView.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

// --- Core base UIView class root --- //
@interface CoreUIView : UIView

// Localization methods
@property (nonatomic, strong)               NSString        *localizationItemName;
- (NSString *)stringWithKey:(NSString *)key;

// UIView setup something
- (void)setup;

@end


// --- Core xib file base UIView class with IB_DESIGNABLE --- //
IB_DESIGNABLE
@interface CoreDesignableXibUIView : CoreUIView

- (id)initWithXib;

@end
