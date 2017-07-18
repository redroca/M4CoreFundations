//
//  UIView+Extension.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

#pragma mark – Override properties

- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    
    frame.origin = origin;
    
    self.frame = frame;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}
- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    
    frame.origin.x = originX;
    
    self.frame = frame;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}
- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    
    frame.origin.y = originY;
    
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
}

- (CGFloat)sizeW {
    return self.frame.size.width;
}
- (void)setSizeW:(CGFloat)sizeW {
    CGRect frame = self.frame;
    
    frame.size.width = sizeW;
    
    self.frame = frame;
}

- (CGFloat)sizeH {
    return self.frame.size.height;
}
- (void)setSizeH:(CGFloat)sizeH {
    CGRect frame = self.frame;
    
    frame.size.height = sizeH;
    
    self.frame = frame;
}

#pragma mark – Public methods
- (UIImage *)screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return anImage;
}

- (void)removeAllSubviews{
    //	for( UIView *subview in self.subviews ){
    //		[subview removeFromSuperview];
    //	}
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)setRoundingCornersDirection:(UIRectCorner) cornersDirection cornerRadius:(CGFloat) radius {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:cornersDirection
                                                        cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.frame = self.bounds;
    shape.path = rounded.CGPath;
    self.layer.mask = shape;
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size strokeColor:(UIColor *) color {
    CGRect bounds = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:size];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer *frameLayer = [CAShapeLayer layer];
    frameLayer.frame = bounds;
    frameLayer.path = maskPath.CGPath;
    frameLayer.strokeColor = color.CGColor;
    frameLayer.fillColor = nil;
    frameLayer.lineWidth = 1*2;
    [self.layer addSublayer:frameLayer];
    
}

- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}


- (void)stackSubviews {
    
    // Init Y position of the first visible subview contained inside the StackerView
    float _y = 0;
    
    for (UIView *subview in self.subviews) {
        // Start by adjusting the Y position of the current subview
        subview.originY = _y;
        
        // If the subview is visible, then add height to the global Y position, which is
        // used to set the Y position of the next subview in the iteration
        if (!subview.hidden) {
            
            // If the subview is a TableView, we use the contentsize instead of the frames height
            if ([subview isMemberOfClass:[UITableView class]]) {
                UITableView *tview = (UITableView *)subview;
                
                _y += tview.contentSize.height;
            } else {
                _y += subview.frame.size.height;
            }
            
            // Increase the height of acctual StackerView with each visible sub-view
            self.sizeH = _y;
        }
    }
}


- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView *subview in self.subviews ) {
        BOOL stop = NO;
        if( recurse( subview, &stop ) ) {
            return [subview findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    
    return nil;
}

- (void)AutoLayoutTrace {
    //po [[UIWindow keyWindow] _autolayoutTrace]
    
#ifdef DEBUG
    //NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#endif
}

- (UIView *)findFirstResponder {
    if ([self isFirstResponder])
        return self;
    
    for (UIView * subView in self.subviews)
    {
        UIView * fr = [subView findFirstResponder];
        if (fr != nil)
            return fr;
    }
    
    return nil;
}
@end
