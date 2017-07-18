//
//  BaseRefreshTableViewController.m
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "BaseRefreshTableViewController.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"


@interface BaseRefreshTableViewController ()

@end


@implementation BaseRefreshTableViewController

- (void)setup {
    [super setup];
    _CurrentPageIndex = [[PageInfoModel alloc] initWithIndex:1];
    _LoadStatus = LoadFirstPageData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)receiveRefreshDataDidFinished:(BOOL)success pageInfo:(PageInfoModel *)pageInfo refreshStatus:(RefreshStatus) status {
    if (success) {
        if (status == LoadFirstPageData) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
        }
        else if (status == LoadMorePageData) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        _LoadStatus = status;
        _CurrentPageIndex = pageInfo;
        
        if (pageInfo.IsLastPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            [pageInfo currentPageIndexIncrease];
        }
        
        [self.tableView reloadData];
    }
    else {
        _CurrentPageIndex = pageInfo;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (void)refreshTableViewWithHeaderSel:(SEL)headerRefreshSelector withFooterRefreshSel:(SEL)footerRefreshSelector {
    //Header
    if (self.tableView.mj_header == nil) {
        RefreshHeader *header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:headerRefreshSelector];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.textColor = [UIColor grayColor];
        header.backgroundColor = [UIColor clearColor];
        self.tableView.mj_header = header;
    }
    
    //Footer
    if (self.tableView.mj_footer == nil) {
        RefreshFooter *footer = [RefreshFooter footerWithRefreshingTarget:self refreshingAction:footerRefreshSelector];
        footer.refreshingTitleHidden = YES;
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        footer.backgroundColor = [UIColor clearColor];
        self.tableView.mj_footer = footer;
    }
}

- (void)refreshTableViewWithSelector:(SEL)refreshSelector {
    //Header
    if (self.tableView.mj_header == nil) {
        RefreshHeader *header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:refreshSelector];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.textColor = [UIColor grayColor];
        header.backgroundColor = [UIColor clearColor];
        self.tableView.mj_header = header;
    }
    
    //Footer
    if (self.tableView.mj_footer == nil) {
        RefreshFooter *footer = [RefreshFooter footerWithRefreshingTarget:self refreshingAction:refreshSelector];
        footer.refreshingTitleHidden = YES;
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        footer.backgroundColor = [UIColor clearColor];
        self.tableView.mj_footer = footer;
    }
}

@end
