

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MessageNotificationType) {
    MessageNotificationTypeMessage = 0,
    MessageNotificationTypeWarning,
    MessageNotificationTypeError,
    MessageNotificationTypeSuccess,
    MessageNotificationTypeClock
};

typedef NS_ENUM(NSInteger, MessageNotificationDuration) {
    MessageNotificationDurationAutomatic = 0,
    MessageNotificationDurationEndless = -1 // The notification is displayed until the user dismissed it or it is dismissed by calling dismissActiveNotification
};


@interface MessageNotificationView : UIView

@property (nonatomic, readonly)     NSString                                    *contentText;
@property (nonatomic, readonly)     UIViewController                            *viewController;
@property (nonatomic, assign)       MessageNotificationDuration                 durationType;
@property (nonatomic, assign)       CGFloat                                     durationTime;
@property (nonatomic, assign)       BOOL                                        isFullyDisplayed;

- (instancetype)initWithContent:(NSString *) content
                    messageType:(MessageNotificationType) msgType
                   durationType:(MessageNotificationDuration) durationType
               inViewController:(UIViewController *) viewController
                      dismissed:(BOOL)canDismiss
                          Block:(void (^)())completeBlock;

- (void)fadeOutMessageView;

@end

