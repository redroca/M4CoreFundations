//
//  CALayer+Extension.m
//  Patrol
//
//  Created by hades on 2017/5/11.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
