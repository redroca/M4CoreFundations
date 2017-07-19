//
//  PageInfo.h
//
//
//  Created by Benjamin on 1/11/2016.
//

#import "ModelBaseClass.h"


typedef NS_ENUM(NSUInteger, RefreshStatus) {
    LoadFirstPageData = 1,
    LoadMorePageData = 2
};

@interface PageInfoModel : ModelBaseClass

@property (nonatomic, assign)      NSInteger        TotalPage;
@property (nonatomic, assign)      NSInteger        TotalCount;
@property (nonatomic, assign)      NSInteger        PageSize;
@property (nonatomic, assign)      NSInteger        PageIndex;

@property (nonatomic, assign, readonly, getter=getIsLastPage)      BOOL             IsLastPage;

- (instancetype)initWithIndex:(NSInteger) index totalCount:(NSInteger) totalCount;
- (instancetype)initWithIndex:(NSInteger) index;
- (instancetype)init;

- (void)currentPageIndexIncrease;
- (void)resetCurrentPageFirstPage;
- (void)setCurrentPageIndex:(NSUInteger) index;

+ (NSDictionary *)buildingPageIndex:(PageInfoModel *) page;

@end
