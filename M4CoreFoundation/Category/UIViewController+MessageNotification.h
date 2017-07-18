
#import <UIKit/UIKit.h>

@interface UIViewController (MessageNotification)

/**
 *  Notifications show from top on current View controller.
 *  Notifciation show with Image and Content.
 *
 *  Notification type : Success,  Info, Warning , Error.
 *  If you use these notifications, you should put some image to project, and named Image as
 *  Success: @"msg_success_tips_icon.png", Info : @"msg_info_tips_icon.png",
 *  Warning: @""msg_warning_tips_icon.png, Error : @"msg_error_tips_icon.png".
 **/


//Notifications
- (void)showSuccessWithContent:(NSString *) content;
- (void)showSuccessWithContent:(NSString *) content isAlwaysDisplay:(BOOL) isDisplay beDismised:(BOOL) dismiss;

- (void)showInfoWithContent:(NSString *) content;
- (void)showWarningWithContent:(NSString *) content;
- (void)showErrorWithContent:(NSString *) content;

@end
