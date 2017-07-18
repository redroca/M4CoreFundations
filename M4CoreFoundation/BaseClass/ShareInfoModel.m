//
//  ShareInfoModel.m
//  
//
//  Created by Benjamin on 1/7/2016.
//

#import "ShareInfoModel.h"

@implementation ShareInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ShareTitle"      : @"title",
             @"ShareContent"    : @"content",
             @"ShareURL"        : @"url",
             @"ShareIconURL"    : @"icon"
             };
}

@end
