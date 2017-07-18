
#import "RESTfulBaseService.h"

@implementation RESTfulBaseService
- (NSDictionary *) buildingPageIndex:(PageInfoModel *) page {
    NSDictionary *dicParams = @{
                                @"page_index" : [@(page.PageIndex) stringValue],
                                @"page_size"  : [@(page.PageSize) stringValue]
                                };
    return dicParams;
}
@end
