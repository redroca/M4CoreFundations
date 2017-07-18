//
//  CoreUILabel.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreUILabel.h"

@implementation CoreUILabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines verticalAlignment:(TextVerticalAlignment )verticalAlignment {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    switch (verticalAlignment) {
        case TextVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case TextVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case TextVerticalAlignmentCenter:
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
    }
    
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines verticalAlignment:self.textVerticalAlignment];
    [super drawTextInRect:actualRect];
}

- (CGSize)sizeOfMultiLineLabel{
    
    NSAssert(self, @"UILabel was nil");
    
    //Width of the Label
    CGFloat aLabelSizeWidth = self.frame.size.width;
    
    return [CoreUILabel estimateSizeOfMultiLineLabelWithContent:[self text] AndFontSie:[self font] AndWidth:aLabelSizeWidth];
}

+ (CGSize)estimateSizeOfMultiLineLabelWithContent:(NSString *) content AndFontSie:(UIFont *) font AndWidth:(CGFloat) width
{
    return [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                 options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{
                                           NSFontAttributeName : font
                                           }
                                 context:nil].size;
}

@end
