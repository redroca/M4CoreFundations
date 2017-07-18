//
//  BaseUIViewController+NavigationButton.m
//  SmallCP
//
//  Created by hades on 2017/7/12.
//  Copyright © 2017年 Ananwu. All rights reserved.
//

#import "BaseUIViewController+NavigationButton.h"
#import <objc/runtime.h>

@implementation BaseUIViewController (NavigationButton)
- (void) setupNavigationButtonBack {
        if( self.navigationController.viewControllers.count > 1 ){
            UIImage *normalImage = [UIImage imageNamed:@"nav_btn_back_nor"];
            UIImage *hightlightedImage = [UIImage imageNamed:@"nav_btn_back_pre"];
            
            UIButton *backBtn = [self setupNavigationBarButton:normalImage highlightedImage:hightlightedImage target:self aciton:@selector(backButtonTapped:) sidePosition:ButtonInLeftNavigationBar];
            self.navigationItem.backBarButtonItem = nil;
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        }
}

- (UIButton *)setupNavigationBarButton:(UIImage *)normalImage
                      highlightedImage:(UIImage *)highlightedImage
                                target:(id)target
                                aciton:(SEL)actionSeletor
                          sidePosition:(NavigationButtonSide) side {
    
    UIButton *barButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [barButton setImage:normalImage forState:UIControlStateNormal];
    [barButton setImage:highlightedImage forState:UIControlStateHighlighted];
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (side == ButtonInRightNavigationBar) {
        insets = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, -10.0f);
        [barButton setImageEdgeInsets:insets];//Offset
    }
    else if (side == ButtonInLeftNavigationBar) {
        insets = UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, 10.0f);
        [barButton setImageEdgeInsets:insets];//Offset
    }
    
    [barButton addTarget:target action:actionSeletor forControlEvents:UIControlEventTouchUpInside];
    
    return barButton;
    
}

- (void)setupNavigationButton:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                 sidePosition:(NavigationButtonSide)side
                withClassName:(NSString *)className {
    UIButton *button = [self setupNavigationBarButton:normalImage highlightedImage:highlightedImage target:self aciton:@selector(pushToViewController) sidePosition:side];
    self.willPushClassName = className;
    if (side == ButtonInLeftNavigationBar) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

- (void) backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToViewController {
    if (self.willPushClassName.length > 0) {
        const char *className = [self.willPushClassName cStringUsingEncoding:NSASCIIStringEncoding];
        Class subClass = object_getClass(self.willPushClassName);
        if (!subClass) {
            Class parentClass = [NSObject class];
            subClass = objc_allocateClassPair(parentClass, className, 0);
            objc_registerClassPair(subClass);
        }
        id instance = [[subClass alloc] init];
        [self.navigationController pushViewController:instance animated:YES];
    }
}

@end
