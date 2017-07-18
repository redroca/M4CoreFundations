
#import <UIKit/UIKit.h>
#import "ServiceResultInfo.h"
#import <AFNetworking/AFNetworking.h>

//HTTP Operation;
#define OPERATION_GET               @"GET"
#define OPERATION_POST              @"POST"
#define OPERATION_PUT               @"PUT"
#define OPERATION_DELETE            @"DELETE"

//Image Operation
#define OPERATION_IMAGE_DOWNLOAD    @"GET"
#define OPERATION_IMAGE_UPLOAD      @"POST"

@class ServiceResultInfo;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
@interface RESTfulAPIWrapper : NSObject

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)operation:(NSString *)action urlResource:(NSString *)url actionCompletion:(RESTfulResultHanlder) completion;

- (NSURLSessionDataTask *)operation:(NSString *)action urlResource:(NSString *)url urlParameters:(NSDictionary *)params actionCompletion:(RESTfulResultHanlder) completion;
- (NSURLSessionDataTask *)operation:(NSString *)action urlResource:(NSString *)url urlParameters:(NSDictionary *)params imgName:(NSString *) name uploadImage:(UIImage *)image actionCompletion:(RESTfulResultHanlder) completion;

@end
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

