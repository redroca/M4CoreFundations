//
//  SocialShareSNS.m
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "SocialShareSNS.h"

@import UIKit;

static SocialShareSNS *_instance = nil;

@interface SocialShareSNS ()
@property (nonatomic, strong) NSArray <UIActivity *> *applicationActivities;
@end

@implementation SocialShareSNS

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [self shareInstance] ;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self shareInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self shareInstance];
}

- (id)copy
{
    return [SocialShareSNS shareInstance];
}

- (id)mutableCopy
{
    return [SocialShareSNS shareInstance];
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

- (NSArray<UIActivity *> *)applicationActivities {
    if (!_applicationActivities) {
        _applicationActivities = [NSArray array];
    }
    return _applicationActivities;
}

#pragma mark - Public Method;
- (void)configShareActivities:(nullable NSArray<__kindof UIActivity *> *)applicationActivities {
    self.applicationActivities = applicationActivities;
}

+ (UIActivityViewController *) shareToSocialActivityWithTitle:(NSString *) title contentText:(NSString *) content shareURL:(NSString *) url iconImgURL:(NSString *) imgURL {
    
    if (title == nil) {
        title = @"";
    }
    
    if (content == nil) {
        content = @"";
    }
    
    if (url == nil) {
        url = @"";
    }
    
    if (imgURL == nil) {
        imgURL = @"";
    }
    
    NSArray *excludedActivityArray = @[
                                       UIActivityTypePostToFacebook,
                                       UIActivityTypePostToTwitter,
                                       UIActivityTypePostToWeibo,
                                       UIActivityTypeMessage,
                                       UIActivityTypeMail,
                                       UIActivityTypePrint,
                                       UIActivityTypeCopyToPasteboard,
                                       UIActivityTypeAssignToContact,
                                       UIActivityTypeSaveToCameraRoll,
                                       UIActivityTypeAddToReadingList,
                                       UIActivityTypePostToFlickr,
                                       UIActivityTypePostToVimeo,
                                       UIActivityTypePostToTencentWeibo,
                                       UIActivityTypeAirDrop
                                       ];
    
    NSDictionary *dic = @{
                          TITILE_KEY: title,
                          CONTENT_KEY: content,
                          URL_KEY: url,
                          IMAGE_KEY: imgURL,
                          };
    
    NSArray *shareItems = @[dic, title, content, url, imgURL];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:shareItems
                                                                               applicationActivities:[SocialShareSNS shareInstance].applicationActivities
                                              ];
    
    activityView.excludedActivityTypes = excludedActivityArray;
    activityView.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {};
    
    return activityView;
}

@end
