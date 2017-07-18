
#import "BaseUIViewController.h"
#import "BaseUIViewController+NavigationButton.h"

@interface BaseUIViewController ()

@end

@implementation BaseUIViewController

- (void) setup {
    [super setup];
    self.needBackNaviButton = YES;
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if( self.needBackNaviButton ){
        [self setupNavigationButtonBack];
    }
}

- (void)showCommonAlertControllerWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancelHandler:(void (^)(UIAlertAction *action))canceHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert showViewController:self sender:nil];
    UIAlertAction *confirmBtn = [UIAlertAction actionWithTitle:confirmTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:confirmHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:canceHandler];
    [alert addAction:confirmBtn];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
