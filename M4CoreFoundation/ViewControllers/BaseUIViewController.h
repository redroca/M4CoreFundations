
#import "CoreUIViewController.h"

@interface BaseUIViewController : CoreUIViewController

// when custom navigation backItem, you should set YES. Default is YES;
@property (nonatomic, assign)   BOOL        needBackNaviButton;

//You should not set this value
@property (nonatomic, copy)     NSString    *willPushClassName;


/**
 Alert wrapper use system UIAlertViewController, easy to use.

 @param title            title
 @param message          detail message
 @param confirmTitle     confirm button's title
 @param cancelTitle      cancel button's title
 @param confirmHandler   confirm block that you can do something when tap confirm
 @param canceHandler     cancel block that you can do something when tap cancel
 */
- (void)showCommonAlertControllerWithTitle:(NSString *)title
                                   message:(NSString *)message
                              confirmTitle:(NSString *)confirmTitle
                               cancelTitle:(NSString *)cancelTitle
                            confirmHandler:(void (^)(UIAlertAction *action))confirmHandler
                             cancelHandler:(void (^)(UIAlertAction *action))canceHandler;
@end
