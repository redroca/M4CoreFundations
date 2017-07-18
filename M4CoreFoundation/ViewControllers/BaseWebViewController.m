//
//  BaseWebViewController.m
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "BaseWebViewController.h"

#import "WebViewProgressView.h"
#import "ShareInfoModel.h"
#import "SocialShareSNS.h"

#import "BaseUIViewController+NavigationButton.h"


#define KVOWebProgressKey           @"estimatedProgress"

@interface BaseWebViewController () <UIScrollViewDelegate>

@end

@implementation BaseWebViewController {
    WebViewProgressView *_progressView;
}
- (void)closeGoBackTapped {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setupWebViewBackButtonNavigationBar {
    UIButton *backBtn = [self setupNavigationBarButton:[UIImage imageNamed:@"nav_btn_back_nor"] highlightedImage:[UIImage imageNamed:@"nav_btn_back_pre"] target:self aciton:@selector(closeGoBackTapped) sidePosition:ButtonInLeftNavigationBar];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)shareSNS {
    if (self.sharingData == nil) {
        return;
    }
    UIActivityViewController *shareVC = [SocialShareSNS shareToSocialActivityWithTitle:self.sharingData.ShareTitle contentText:self.sharingData.ShareContent shareURL:self.sharingData.ShareURL.absoluteString iconImgURL:self.sharingData.ShareIconURL.absoluteString];
    [self presentViewController:shareVC animated:YES completion:^{}];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:KVOWebProgressKey] && object == self.webView) {
        NSLog(@"%f", self.webView.estimatedProgress);
        // estimatedProgress is a value from 0.0 to 1.0
        // Update your UI here accordingly
        [_progressView setProgress:self.webView.estimatedProgress animated:YES];
    }
    else {
        // Make sure to call the superclass's implementation in the else block in case it is also implementing KVO
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)loadView {
    [super loadView];
    self.webView = [[WKWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.view sendSubviewToBack:self.webView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[WebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_progressView setProgress:0.0 animated:NO];
    
    self.webView.scrollView.delegate = self;
    [self.webView addObserver:self forKeyPath:KVOWebProgressKey options:NSKeyValueObservingOptionNew context:NULL];
    self.webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - navigationBarBounds.size.height - 20);
    
    if(self.sharingData != nil) {
        //TODO:SNS imp
        //[self setupNavigationButtonShareWith:@selector(shareSNS)];
    }
    //TODO:SNS imp
    //[self setupNavigationButtonCloseWith:@selector(closeGoBackTapped)];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:KVOWebProgressKey];
    self.webView.scrollView.delegate = nil;
    // if you have set either WKWebView delegate also set these to nil here
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

#pragma mark --- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

@end
