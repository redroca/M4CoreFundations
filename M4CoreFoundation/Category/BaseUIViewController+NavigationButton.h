//
//  BaseUIViewController+NavigationButton.h
//  SmallCP
//
//  Created by hades on 2017/7/12.
//  Copyright © 2017年 Ananwu. All rights reserved.
//

#import "BaseUIViewController.h"

@interface BaseUIViewController (NavigationButton)
typedef NS_ENUM(NSInteger, NavigationButtonSide) {
    ButtonInLeftNavigationBar = 1,
    ButtonInRightNavigationBar = 2,
};

/**
 * set global back button. But you should set back buttom normal image with name "nav_btn_back_nor.png" and highlighted image with name "nav_btn_back_pre.png" in Images bundles.
 */
- (void) setupNavigationButtonBack;


/**
 Custom create NavigationItem.

 @param normalImage         show NavigationItem normal
 @param highlightedImage    show NavigationItem highlighted when tap on item
 @param target              current object to add NavigtionItem
 @param actionSeletor       seletor to handle jump action
 @param side                which side you should add, left or right
 @return                    custon button
 */
- (UIButton *)setupNavigationBarButton:(UIImage *)normalImage
                      highlightedImage:(UIImage *)highlightedImage
                                target:(id)target
                                aciton:(SEL)actionSeletor
                          sidePosition:(NavigationButtonSide) side;


/**
 set specific NavigationItem with normal Image and highlighted image

 @param normalImage         normal image
 @param highlightedImage    highlighted image
 @param side                which side you should add, left or right
 @param className           the controller you want to push
 */
- (void)setupNavigationButton:(UIImage *)normalImage
             highlightedImage:(UIImage *)highlightedImage
                 sidePosition:(NavigationButtonSide)side
                withClassName:(NSString *)className;
@end
