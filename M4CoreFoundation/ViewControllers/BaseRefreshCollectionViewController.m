//
//  BaseRefreshCollectionViewController.m
//  Test
//
//  Created by hades on 2017/7/13.
//  Copyright © 2017年 Hades. All rights reserved.
//


#import "BaseRefreshCollectionViewController.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"

@interface BaseRefreshCollectionViewController ()

@end

@implementation BaseRefreshCollectionViewController

- (void)setup {
    [super setup];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _CurrentPageIndex = [[PageInfoModel alloc] initWithIndex:1];
    _LoadStatus = LoadFirstPageData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiveRefreshDataDidFinished:(BOOL)success pageInfo:(PageInfoModel *)pageInfo refreshStatus:(RefreshStatus) status {
    if (success) {
        if (status == LoadFirstPageData) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer resetNoMoreData];
        }
        else if (status == LoadMorePageData) {
            [self.collectionView.mj_footer endRefreshing];
        }
        _LoadStatus = status;
        _CurrentPageIndex = pageInfo;
        
        if (pageInfo.IsLastPage) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            [pageInfo currentPageIndexIncrease];
        }
        
        [self.collectionView reloadData];
    }
    else {
        _CurrentPageIndex = pageInfo;
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_footer resetNoMoreData];
    }
}

- (void)refreshCollectionViewWithHeaderSel:(SEL)headerRefreshSelector withFooterRefreshSel:(SEL)footerRefreshSelector {
    
    //Header
    if (self.collectionView.mj_header == nil) {
        RefreshHeader *header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:headerRefreshSelector];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.textColor = [UIColor grayColor];
        header.backgroundColor = [UIColor clearColor];
        self.collectionView.mj_header = header;
    }
    
    //Footer
    if (self.collectionView.mj_footer == nil) {
        RefreshFooter *footer = [RefreshFooter footerWithRefreshingTarget:self refreshingAction:footerRefreshSelector];
        footer.refreshingTitleHidden = YES;
        footer.backgroundColor = [UIColor clearColor];
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        self.collectionView.mj_footer = footer;
    }
}

- (void)refreshCollectionViewWithSelector:(SEL)refreshSelector {
    //Header
    if (self.collectionView.mj_header == nil) {
        RefreshHeader *header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:refreshSelector];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.textColor = [UIColor grayColor];
        header.backgroundColor = [UIColor clearColor];
        self.collectionView.mj_header = header;
    }
    
    //Footer
    if (self.collectionView.mj_footer == nil) {
        RefreshFooter *footer = [RefreshFooter footerWithRefreshingTarget:self refreshingAction:refreshSelector];
        footer.refreshingTitleHidden = YES;
        footer.backgroundColor = [UIColor clearColor];
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        self.collectionView.mj_footer = footer;
    }
}

@end
