//
//  SocialShareSNS.h
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UIActivityViewController;


#define     TITILE_KEY      @"title_key"
#define     CONTENT_KEY     @"content_key"
#define     URL_KEY         @"url_key"
#define     IMAGE_KEY       @"image_key"

@interface SocialShareSNS : NSObject


/**
 Set platforms you want to share .

 @param applicationActivities   UIActivityViewController
 */
- (void)configShareActivities:(NSArray< UIActivity *> *)applicationActivities;


/**
 Setting share info

 @param title       share title
 @param content     share content
 @param url         share url
 @param imgURL      share image url
 @return            UIActivityViewController's object, then you should present the object.
 */
+ (UIActivityViewController *) shareToSocialActivityWithTitle:(NSString *) title
                                                  contentText:(NSString *) content
                                                     shareURL:(NSString *) url
                                                   iconImgURL:(NSString *) imgURL;

@end
