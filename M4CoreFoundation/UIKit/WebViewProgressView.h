//
//  WebViewProgressView.h
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreUIView.h"

@interface WebViewProgressView : CoreUIView

@property (nonatomic, assign) float             progress;

@property (nonatomic, strong) UIView            *progressBarView;
@property (nonatomic, assign) NSTimeInterval    barAnimationDuration; // default 0.1
@property (nonatomic, assign) NSTimeInterval    fadeAnimationDuration; // default 0.27
@property (nonatomic, assign) NSTimeInterval    fadeOutDelay; // default 0.1

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
