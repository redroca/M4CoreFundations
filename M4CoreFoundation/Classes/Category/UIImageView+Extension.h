//
//  UIImageView+Extension.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ImageCompletionBlock)(BOOL loadFinish, UIImage *image, NSURL *url, NSError *error);

@interface UIImageView (Extension)

- (void) img:(NSURL *) url withPlaceholder:(UIImage *) img completion:(ImageCompletionBlock)completion;

@end
