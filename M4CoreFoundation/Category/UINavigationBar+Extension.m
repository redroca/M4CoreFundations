

#import "UINavigationBar+Extension.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BackgroundColor)
- (void)setupBarBackgroundColor:(UIColor *)backgroundColor
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            view.backgroundColor = backgroundColor;
        }
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            self.barTintColor = backgroundColor;
        }
    }
}

@end




@implementation UINavigationBar (HideBottomLine)


/**
 * Hide 1px hairline of the nav bar
 */
- (void)hideBottomHairline {
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = YES;
}

/**
 * Show 1px hairline of the nav bar
 */
- (void)showBottomHairline {
    // Show 1px hairline of translucent nav bar
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = NO;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
