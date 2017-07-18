//
//  ServiceResultInfo.m
//  SmallCP
//
//  Created by Benjamin on 3/6/17.
//  Copyright © 2017 Ananwu. All rights reserved.
//

#import "ServiceResultInfo.h"
#import "NotificationsName.h"

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

@implementation ServiceResultInfo

- (instancetype)initWithHTTPStatusCode:(HTTPStatusCode) httpCode errorInfo:(NSError *) error descriptionInfo:(NSString *) desription errorCode:(NSString *) code finishStatus:(BOOL) status {
    if (self = [super init]) {
        _statusCode = httpCode;
        _errorInfo = error;
        _descriptionMsg = desription;
        _errorCode = code;
        _finishStatus = status;
        
        //需要重新登录...
        if ((httpCode ==403)||((httpCode == 401 )&&([code isEqualToString:@"00002"]))) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ExpiredToken object:nil];
        }
    }
    return self;
}

- (instancetype)initWithErrorDescriptionInfo:(NSString *) desription errorCode:(NSString *) code finishStatus:(BOOL) status {
    if (self = [super init]) {
        _descriptionMsg = desription;
        _errorCode = code;
        _finishStatus = status;
    }
    return self;
}


#pragma mark --- Override

- (NSString *)description
{
    NSString *finish =          _finishStatus ? @"Status - [YES]" : @"Status - [NO]";
    NSString *httpCode =        [NSString stringWithFormat:@"HTTP Status Code - [%ld]", (long)_statusCode];
    NSString *infoDescription = [NSString stringWithFormat:@"Description - [%@]", _descriptionMsg];
    NSString *errorCode =       [NSString stringWithFormat:@"Error Code - [%@]", _errorCode];
    NSString *errorString =     [NSString stringWithFormat:@"Error Msg - [%@]", _errorInfo];
    
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@", finish, httpCode, infoDescription, errorCode, errorString];
}

@end

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
