

#import "UIViewController+MessageNotification.h"

#import "MessageNotificationManager.h"


@implementation UIViewController (Notification)

- (void)showSuccessWithContent:(NSString *) content {
    [self showMessage:content withMsgType:MessageNotificationTypeSuccess];
}

- (void)showSuccessWithContent:(NSString *) content isAlwaysDisplay:(BOOL) isDisplay beDismised:(BOOL) dismiss {
    [self showMessage:content isAlwaysShow:isDisplay beDismised:dismiss];
}

- (void)showInfoWithContent:(NSString *) content {
    [self showMessage:content withMsgType:MessageNotificationTypeMessage];
}

- (void)showWarningWithContent:(NSString *) content {
    [self showMessage:content withMsgType:MessageNotificationTypeWarning];
}

- (void)showErrorWithContent:(NSString *) content {
    [self showMessage:content withMsgType:MessageNotificationTypeError];
}

- (void)showMessage:(NSString *) msg withMsgType:(MessageNotificationType) type {
    [MessageNotificationManager setDefaultViewController:self];
    [MessageNotificationManager showMessageWithConctent:msg messageType:type];
}

- (void)showMessage:(NSString *) msg isAlwaysShow:(BOOL) isAlways beDismised:(BOOL) dismiss {
    [MessageNotificationManager setDefaultViewController:self];
    
    MessageNotificationDuration duration;
    if (isAlways) {
        duration = MessageNotificationDurationEndless;
    }
    else {
        duration = MessageNotificationDurationAutomatic;
    }
    
    [MessageNotificationManager showMessageWithConctent:msg messageType:MessageNotificationTypeSuccess durationType:duration beDismised:dismiss];
}

@end
