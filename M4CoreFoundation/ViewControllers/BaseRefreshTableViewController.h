//
//  BaseRefreshTableViewController.h
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "BaseTableViewController.h"

#import "PageInfoModel.h"


@interface BaseRefreshTableViewController : BaseTableViewController {
    PageInfoModel           *_CurrentPageIndex;
    RefreshStatus           _LoadStatus;
}

- (void)receiveRefreshDataDidFinished:(BOOL)success pageInfo:(PageInfoModel *)pageInfo refreshStatus:(RefreshStatus) status;

- (void)refreshTableViewWithHeaderSel:(SEL)headerRefreshSelector withFooterRefreshSel:(SEL)footerRefreshSelector;

- (void)refreshTableViewWithSelector:(SEL)refreshSelector;

@end
