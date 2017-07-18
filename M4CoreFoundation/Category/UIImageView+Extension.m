//
//  UIImageView+Extension.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "YYWebImage.h"

@implementation UIImageView (Extension)

- (void) img:(NSURL *) url withPlaceholder:(UIImage *) img completion:(ImageCompletionBlock)completion {
    if (![[url absoluteString] hasPrefix:@"http"] && url) {

        self.image = [UIImage imageWithContentsOfFile:url.absoluteString];
        return;
    }
    
    [self yy_setImageWithURL:url
                 placeholder:img
                     options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressive
                  completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
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

@end
