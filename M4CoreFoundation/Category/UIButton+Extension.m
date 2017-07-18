//
//  UIButton+Extension.m
//  Patrol
//
//  Created by hades on 2017/5/15.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "UIButton+Extension.h"
#import <YYWebImage/YYWebImage.h>

@implementation UIButton (Extension)
- (void)setImage:(NSURL *)url
 withPlaceholder:(UIImage *) img
        forState:(UIControlState)state
      completion:(ImageCompletionBlock)completion
{
    [self yy_setImageWithURL:url
                    forState:state
                 placeholder:img
                     options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressive
                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                      if (error != nil) {
                          if (completion) {
                              completion(NO, image, url, error);
                          }
                      }
                      else {
                          if (completion) {
                              completion(YES, image, url, error);
                          }
                      }
                  }];
}

- (void)setBackgroundImageWithURL:(NSURL *)url
                  withPlaceholder:(UIImage *) img
                         forState:(UIControlState)state
                       completion:(ImageCompletionBlock)completion
{
    [self yy_setBackgroundImageWithURL:url
                              forState:state
                           placeholder:img
                               options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressive
                            completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                if (error != nil) {
                                    completion(NO, image, url, error);
                                }
                                else {
                                    completion(YES, image, url, error);
                                }
                            }];
}
@end
