//
//  ServiceResultInfo.h
//  SmallCP
//
//  Created by Benjamin on 3/6/17.
//  Copyright © 2017 Ananwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPStatusCodes.h"

@class ServiceResultInfo;


//Result Block
typedef void (^RESTfulResultHanlder)(id responsedata, ServiceResultInfo *resultStatusInfo);

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

@interface ServiceResultInfo : NSObject

@property (nonatomic, assign) HTTPStatusCode        statusCode;
@property (nonatomic, strong) NSError               *errorInfo;
@property (nonatomic, copy)   NSString              *descriptionMsg;
@property (nonatomic, copy)   NSString              *errorCode;
@property (nonatomic, assign) NSTimeInterval        timestamp;
@property (nonatomic, assign) BOOL                  finishStatus;

- (instancetype)initWithHTTPStatusCode:(HTTPStatusCode) httpCode errorInfo:(NSError *) error descriptionInfo:(NSString *) desription errorCode:(NSString *) code finishStatus:(BOOL) status;
- (instancetype)initWithErrorDescriptionInfo:(NSString *) desription errorCode:(NSString *) code finishStatus:(BOOL) status;

@end

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
