//
//  BaseRefreshCollectionViewController.h
//  Test
//
//  Created by hades on 2017/7/13.
//  Copyright © 2017年 Hades. All rights reserved.
//

#import "BaseCollectionViewController.h"

#import "PageInfoModel.h"

@interface BaseRefreshCollectionViewController : BaseCollectionViewController {
    PageInfoModel           *_CurrentPageIndex;
    RefreshStatus           _LoadStatus;
}

- (void)receiveRefreshDataDidFinished:(BOOL)success pageInfo:(PageInfoModel *)pageInfo refreshStatus:(RefreshStatus) status;

- (void)refreshCollectionViewWithHeaderSel:(SEL)headerRefreshSelector withFooterRefreshSel:(SEL)footerRefreshSelector;

- (void)refreshCollectionViewWithSelector:(SEL)refreshSelector;

@end

