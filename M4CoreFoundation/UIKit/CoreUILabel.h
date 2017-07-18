//
//  CoreUILabel.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TextVerticalAlignment) {
    TextVerticalAlignmentCenter,
    TextVerticalAlignmentTop,
    TextVerticalAlignmentBottom
};

@interface CoreUILabel : UILabel

@property(nonatomic, assign) TextVerticalAlignment textVerticalAlignment;

- (CGSize)sizeOfMultiLineLabel;

+ (CGSize)estimateSizeOfMultiLineLabelWithContent:(NSString *) content AndFontSie:(UIFont *) font AndWidth:(CGFloat) width;

@end
