//
//  PageInfo.m
//
//
//  Created by Benjamin on 1/11/2016.
//

#import "PageInfoModel.h"


#define xTotalPage         @"total_pages"
#define xTotalCount        @"total_count"
#define xPageIndex         @"page_index"
#define xPageSize          @"page_size"
#define kPageSize          20


@interface PageInfoModel()

@property (nonatomic, assign)      BOOL             IsLastPage;

@end


@implementation PageInfoModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
                @"TotalPage"       : xTotalPage,
                @"TotalCount"      : xTotalCount,
                @"PageIndex"       : xPageIndex,
                @"PageSize"        : xPageSize,
             };
}

- (instancetype)initWithIndex:(NSInteger) index totalCount:(NSInteger) totalCount {
    if (self = [super init]) {
        if (index == 0) {
            index = NSINTEGER_DEFINED;
        }
        _PageIndex = index;
        _TotalCount = totalCount;
        _TotalPage = ceil( (_TotalCount / kPageSize) );
        _PageSize = kPageSize;
        if (_PageIndex == _TotalPage) {
            _IsLastPage = YES;
        }
        else {
            _IsLastPage = NO;
        }
    }
    return self;
}

- (instancetype)initWithIndex:(NSInteger) index {
    if (self = [super init]) {
        if (index == 0) {
            index = NSINTEGER_DEFINED;
        }
        _PageIndex = index;
        _TotalCount = NSUIntegerMax;
        _PageSize = kPageSize;
        _TotalPage = ceil( (_TotalCount / kPageSize) );
        _IsLastPage = NO;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _PageIndex = NSINTEGER_DEFINED;
        _TotalCount = NSUIntegerMax;
        _PageSize = kPageSize;
        _TotalPage = ceil( (_TotalCount / kPageSize) );
        _IsLastPage = NO;
    }
    return self;
}

- (void)currentPageIndexIncrease {
    _PageIndex += NSINTEGER_DEFINED;
}

- (void)resetCurrentPageFirstPage {
    _PageIndex = NSINTEGER_DEFINED;
    _TotalCount = -1;
}

- (void)setCurrentPageIndex:(NSUInteger) index {
    _PageIndex = index;
}

+ (NSDictionary *) buildingPageIndex:(PageInfoModel *) page {
   return @{
            xPageIndex : [@(page.PageIndex) stringValue],
            xPageSize  : [@(page.PageSize) stringValue]
            };
}

- (BOOL)getIsLastPage {
    if (_PageIndex == _TotalPage) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
