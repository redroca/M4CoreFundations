//
//  RefreshFooter.m
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "RefreshFooter.h"

@implementation RefreshFooter

- (void)prepare
{
    [super prepare];
    self.automaticallyHidden = YES;
    //    // 设置正在刷新状态的动画图片
    //    NSMutableArray *refreshingImages = [NSMutableArray array];
    //    for (NSUInteger i = 73; i<=140; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"PullToRefresh_%03zd", i]];
    //        [refreshingImages addObject:image];
    //    }
    //
    //    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
