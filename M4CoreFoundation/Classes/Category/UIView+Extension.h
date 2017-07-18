//
//  UIView+Extension.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat sizeW;
@property (nonatomic, assign) CGFloat sizeH;

- (UIImage *)screenshot;

- (void)removeAllSubviews;

- (void)setRoundingCornersDirection:(UIRectCorner) cornersDirection cornerRadius:(CGFloat) radius;
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size strokeColor:(UIColor *) color;

- (void)stackSubviews;

- (UIView *)findViewRecursively:(BOOL(^)(UIView *subview, BOOL *stop))recurse;

- (void)AutoLayoutTrace;

- (UIView *)findFirstResponder;

/**
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end
