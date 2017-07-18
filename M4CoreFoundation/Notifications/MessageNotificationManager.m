

#import "MessageNotificationManager.h"

#define kMessageAnimationDuration 0.3
#define kMessageDisplayTime 1.5
#define kMessageExtraDisplayTimePerPixel 0.04


@interface MessageNotificationManager()

@property (nonatomic, strong) NSMutableArray *messagesList;

- (void)fadeInCurrentNotification;
- (void)fadeOutNotification:(MessageNotificationView *)currentView;

@end

@implementation MessageNotificationManager

static BOOL notificationActive;
__weak static UIViewController *_defaultViewController;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

static MessageNotificationManager *SINGLETON = nil;
static BOOL isFirstAccess = YES;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
        SINGLETON.messagesList = [[NSMutableArray alloc] init];
    });
    
    return SINGLETON;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[MessageNotificationManager alloc] init];
}

- (id)mutableCopy
{
    return [[MessageNotificationManager alloc] init];
}

- (id)init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        NSAssert(NO, @"Cannot create instance of Singleton");
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


+ (void)prepareNotificationToBeShown:(MessageNotificationView *)messageView {
    NSString *content = messageView.contentText;
    
    for (MessageNotificationView *n in [MessageNotificationManager sharedInstance].messagesList)
    {
        if (([n.contentText isEqualToString:content] || (!n.contentText && !content)))
        {
            return; // avoid showing the same messages twice in a row
        }
    }
    
    [[MessageNotificationManager sharedInstance].messagesList addObject:messageView];
    
    if (!notificationActive)
    {
        [[MessageNotificationManager sharedInstance] fadeInCurrentNotification];
    }
}

+ (BOOL)dismissActiveNotification {
    if ([[MessageNotificationManager sharedInstance].messagesList count] == 0) {
        return NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       MessageNotificationView *currentMessage = [[MessageNotificationManager sharedInstance].messagesList objectAtIndex:0];
                       if (currentMessage.isFullyDisplayed) {
                           [[MessageNotificationManager sharedInstance] fadeOutNotification:currentMessage];
                       }
                   });
    return YES;
}

- (void)fadeInCurrentNotification {
    if ([self.messagesList count] == 0) {
        return;
    }
    
    notificationActive = YES;
    
    MessageNotificationView *currentView = [self.messagesList objectAtIndex:0];
    
    __block CGFloat verticalOffset = 0.0f;
    
    void (^addStatusBarHeightToVerticalOffset)() = ^void() {
        BOOL isPortrait = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
        CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
        CGFloat offset = isPortrait ? statusBarSize.height : statusBarSize.width;
        verticalOffset += offset;
    };
    
    if ([currentView.viewController isKindOfClass:[UINavigationController class]] || [currentView.viewController.parentViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *currentNavigationController;
        
        if([currentView.viewController isKindOfClass:[UINavigationController class]]) {
            currentNavigationController = (UINavigationController *)currentView.viewController;
        } else {
            currentNavigationController = (UINavigationController *)currentView.viewController.parentViewController;
        }
        
        BOOL isViewIsUnderStatusBar = [[[currentNavigationController childViewControllers] firstObject] extendedLayoutIncludesOpaqueBars];
        if (!isViewIsUnderStatusBar) {
            isViewIsUnderStatusBar = ![currentNavigationController isNavigationBarHidden]; // strange but true
        }
        
        if (![currentNavigationController isNavigationBarHidden])
        {
            [currentNavigationController.view insertSubview:currentView
                                               belowSubview:[currentNavigationController navigationBar]];
            verticalOffset = [currentNavigationController navigationBar].bounds.size.height;
            if (isViewIsUnderStatusBar) {
                addStatusBarHeightToVerticalOffset();
            }
        }
        else
        {
            [currentView.viewController.view addSubview:currentView];
            if (isViewIsUnderStatusBar) {
                addStatusBarHeightToVerticalOffset();
            }
        }
    }
    else
    {
        [currentView.viewController.view addSubview:currentView];
        addStatusBarHeightToVerticalOffset();
    }
    
    CGFloat navigationbarBottomOfViewController = 0;
    CGPoint toPoint = CGPointMake(currentView.center.x, navigationbarBottomOfViewController + verticalOffset + CGRectGetHeight(currentView.frame) / 2.0);
    
    dispatch_block_t animationBlock = ^{
        currentView.center = toPoint;
    };
    void(^completionBlock)(BOOL) = ^(BOOL finished) {
        currentView.isFullyDisplayed = YES;
    };
    
    [UIView animateWithDuration:kMessageAnimationDuration + 0.1
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:animationBlock
                     completion:completionBlock];
    
    if (currentView.durationType == MessageNotificationDurationAutomatic)
    {
        currentView.durationTime = kMessageAnimationDuration + kMessageDisplayTime + currentView.frame.size.height * kMessageExtraDisplayTimePerPixel;
    }
    
    if (currentView.durationType != MessageNotificationDurationEndless)
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self performSelector:@selector(fadeOutNotification:)
                                      withObject:currentView
                                      afterDelay:currentView.durationTime];
                       });
    }
}

- (void)fadeOutNotification:(MessageNotificationView *)currentView {
    currentView.isFullyDisplayed = NO;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOutNotification:) object:currentView];
    CGPoint fadeOutToPoint = CGPointMake(currentView.center.x, -CGRectGetHeight(currentView.frame)/2.f);
    
    [UIView animateWithDuration:kMessageAnimationDuration animations:^ {
        currentView.center = fadeOutToPoint;
        currentView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [currentView removeFromSuperview];
        if ([self.messagesList count] > 0) {
            [self.messagesList removeObjectAtIndex:0];
        }
        notificationActive = NO;
        if ([self.messagesList count] > 0) {
            [self fadeInCurrentNotification];
        }
    }];
}

+ (void)setDefaultViewController:(UIViewController *)defaultViewController {
    _defaultViewController = defaultViewController;
}

+ (UIViewController *)defaultViewController {
    __strong UIViewController *defaultViewController = _defaultViewController;
    if (!defaultViewController) {
        defaultViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return defaultViewController;
}

+ (BOOL)isNotificationActive {
    return notificationActive;
}


+ (void)showMessageWithConctent:(NSString *) content messageType:(MessageNotificationType) msgType {
    [self showMessageWithConctent:content messageType:msgType durationType:MessageNotificationDurationAutomatic];
}
+ (void)showMessageWithConctent:(NSString *) content messageType:(MessageNotificationType) msgType durationType:(MessageNotificationDuration) durationType {
    [self showMessageWithConctent:content messageType:msgType durationType:durationType beDismised:YES];
}
+ (void)showMessageWithConctent:(NSString *) content messageType:(MessageNotificationType) msgType durationType:(MessageNotificationDuration) durationType beDismised: (BOOL)dismissingEnabled {
    [self showMessageWithConctent:content messageType:msgType durationType:durationType beDismised:dismissingEnabled completeBlock:nil];
}
+ (void)showMessageWithConctent:(NSString *) content messageType:(MessageNotificationType) msgType durationType:(MessageNotificationDuration) durationType beDismised: (BOOL)dismissingEnabled completeBlock:(void (^)())block {
    MessageNotificationView *view = [[MessageNotificationView alloc] initWithContent:content messageType:msgType durationType:durationType inViewController:[self defaultViewController] dismissed:dismissingEnabled Block:block];
    [self prepareNotificationToBeShown:view];
}
@end
