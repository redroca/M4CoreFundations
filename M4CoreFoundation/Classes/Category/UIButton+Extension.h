//
//  UIButton+Extension.h
//  Patrol
//
//  Created by hades on 2017/5/15.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ImageCompletionBlock)(BOOL loadFinish, UIImage *image, NSURL *url, NSError *error);

@interface UIButton (Extension)
- (void)setImage:(NSURL *)url
 withPlaceholder:(UIImage *) img
        forState:(UIControlState)state
      completion:(ImageCompletionBlock)completion;

- (void)setBackgroundImageWithURL:(NSURL *)url
                  withPlaceholder:(UIImage *) img
                         forState:(UIControlState)state
                       completion:(ImageCompletionBlock)completion;
@end
