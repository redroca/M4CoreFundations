
#import "MessageNotificationView.h"
#import "MessageNotificationManager.h"
#import "CoreUILabel.h"

#define MessageViewPadding 15.0
#define MessageLabelPadding 8.0



@interface MessageNotificationView (MessageNotificationView)

- (void)fadeOutNotification:(MessageNotificationView *)currentView;

@end


@interface MessageNotificationView() <UIGestureRecognizerDelegate>

@property (nonatomic, strong)       NSString                *contentText;
@property (nonatomic, strong)       UIViewController        *viewController;
@property (nonatomic, strong)       CoreUILabel             *contentLabel;
@property (nonatomic, strong)       UIImageView             *iconImageView;
@property (nonatomic, assign)       CGFloat                 textSpaceLeft;
@property (nonatomic, assign)       CGFloat                 textSpaceRight;
@property (copy) void (^completeBlock)();

@end


@implementation MessageNotificationView

- (instancetype)initWithContent:(NSString *) content
                    messageType:(MessageNotificationType) msgType
                   durationType:(MessageNotificationDuration) durationType
               inViewController:(UIViewController *) viewController
                      dismissed:(BOOL)canDismiss
                          Block:(void (^)())completeBlock {
    if ((self = [self init])) {
        _contentText = content;
        _durationType = durationType;
        _viewController = viewController;
        _completeBlock = completeBlock;
        _isFullyDisplayed = NO;
        
        [self initMessageIcon:msgType];
        [self initContentText:content];
        
        CGFloat actualHeight = [self updateHeightOfMessageView]; // this call also takes care of positioning the labels
        CGFloat topPosition = -actualHeight;
        CGFloat screenWidth = self.viewController.view.bounds.size.width;
        self.frame = CGRectMake(0.0, topPosition, screenWidth, actualHeight);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        if (canDismiss) {
            [self initGestures];
        }
    }
    return self;
}

- (void)initMessageIcon:(MessageNotificationType) type {
    
    NSString *imgFileName = nil;
    
    switch (type)
    {
        case MessageNotificationTypeMessage:
        {
            imgFileName = @"msg_info_tips_icon";
            break;
        }
        case MessageNotificationTypeError:
        {
            imgFileName = @"msg_error_tips_icon";
            break;
        }
        case MessageNotificationTypeSuccess:
        {
            imgFileName = @"msg_success_tips_icon";
            break;
        }
        case MessageNotificationTypeWarning:
        {
            imgFileName = @"msg_warning_tips_icon";
            break;
        }
        case MessageNotificationTypeClock: {
            imgFileName = @"msg_warning_tips_icon";
            break;
        }
        default:
            break;
    }
    
    UIImage *img = [UIImage imageNamed:imgFileName];
    _iconImageView = [[UIImageView alloc] initWithImage:img];
    self.iconImageView.frame = CGRectMake(MessageViewPadding, MessageViewPadding,
                                          img.size.width, img.size.height);
    [self addSubview:_iconImageView];
    
    self.textSpaceLeft += img.size.width + (2 * MessageViewPadding);
}

- (void)initContentText:(NSString *) text {
    _contentLabel = [[CoreUILabel alloc] init];
    _contentLabel.text = text;
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textVerticalAlignment = TextVerticalAlignmentCenter;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_contentLabel];
}

- (void)initGestures {
    UISwipeGestureRecognizer *gestureSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(fadeOutMessageView)];
    [gestureSwip setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self addGestureRecognizer:gestureSwip];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fadeOutMessageView)];
    [self addGestureRecognizer:tapRec];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView:)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
}

- (CGFloat)updateHeightOfMessageView {
    CGFloat screenWidth = self.viewController.view.bounds.size.width;
    CGFloat currentHeight = self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + MessageLabelPadding;
    if (currentHeight <= 32.0f) {
        currentHeight = 56;
    }
    [self.contentLabel sizeToFit];
    CGFloat labelWidth = 0.0f;
    if (self.contentLabel.frame.size.height < 28) {
        labelWidth = screenWidth - (self.textSpaceLeft * 2);
    }
    else {
        labelWidth = screenWidth - self.textSpaceLeft;
    }
    self.contentLabel.frame = CGRectMake(self.textSpaceLeft + 4,    //X
                                         0.0,   //Y
                                         labelWidth - 4, //Width
                                         currentHeight  // Height
                                         );
    self.iconImageView.center = CGPointMake([self.iconImageView center].x, round(currentHeight / 2.0));
    self.frame = CGRectMake(0.0, self.frame.origin.y, self.frame.size.width, currentHeight);

    return currentHeight;
}

- (void)fadeOutMessageView {
    [[MessageNotificationManager sharedInstance] performSelectorOnMainThread:@selector(fadeOutNotification:) withObject:self waitUntilDone:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateHeightOfMessageView];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if ( (self.durationType == MessageNotificationDurationEndless) && self.superview && !self.window )
    {
        // view controller was dismissed, let's fade out
        [self fadeOutMessageView];
    }
}

#pragma mark – Target action methods

- (void)handleTapView:(UITapGestureRecognizer *) tapGesture {
    if (tapGesture.state == UIGestureRecognizerStateRecognized)
    {
        if (self.completeBlock)
        {
            self.completeBlock();
        }
        
        [self fadeOutMessageView];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return ! ([touch.view isKindOfClass:[UIControl class]]);
}

@end

