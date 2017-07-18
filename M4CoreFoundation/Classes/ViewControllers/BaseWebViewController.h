//
//  BaseWebViewController.h
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "BaseUIViewController.h"

#import <WebKit/WebKit.h>

@class ShareInfoModel;


@interface BaseWebViewController : BaseUIViewController

@property (nonatomic, strong)    WKWebView       *webView;
@property (nonatomic, strong)    ShareInfoModel  *sharingData;

- (void)setupWebViewBackButtonNavigationBar;


/**
 * When you call this method, you should ensure that you had config share paltform activities that you want to share.
 * If no, you should use SocialShareSNS class call - (void)configShareActivities:(NSArray< UIActivity *> *)applicationActivities;
 *
 */
- (void)shareSNS;

@end
