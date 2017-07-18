
#import "RESTfulAPIWrapper.h"

@interface RESTfulAPIWrapper()

@property (nonatomic, strong) AFHTTPSessionManager *networkManager;

@end


@implementation RESTfulAPIWrapper

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

static RESTfulAPIWrapper *_sharedSingleton = nil;
static BOOL isFirstAccess = YES;

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[RESTfulAPIWrapper alloc] init];
}

- (id)mutableCopy
{
    return [[RESTfulAPIWrapper alloc] init];
}

- (id)init
{
    if(_sharedSingleton){
        return _sharedSingleton;
    }
    if (isFirstAccess) {
        NSAssert(NO, @"Cannot create instance of Singleton");
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        //timestampSkewing = 0;
        _sharedSingleton = [[super allocWithZone:NULL] init];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedSingleton.networkManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
//        _sharedSingleton.networkManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:RESTFUL_BASE_HOST]
//                                                                   sessionConfiguration:configuration];
    });
    return _sharedSingleton;
}

- (NSURLSessionDataTask *)operation:(NSString *)action urlResource:(NSString *)url actionCompletion:(RESTfulResultHanlder) completion {
    self.networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *jsonResponse = [AFJSONResponseSerializer serializer];
    //jsonResponse.removesKeysWithNullValues = YES;
    self.networkManager.responseSerializer = jsonResponse;
    
    NSMutableURLRequest *request = [self buildURLRequestWithAction:action withURL:url withParameters:nil];
    NSURLSessionDataTask *task = [self executeOperation:request withCompletion:^(id responsedata, ServiceResultInfo *info) { completion(responsedata, info); }];

    [task resume];
    return task;
}

- (NSURLSessionDataTask *)operation:(NSString *)action urlResource:(NSString *)url urlParameters:(NSDictionary *)params actionCompletion:(RESTfulResultHanlder) completion {
    self.networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *jsonResponse = [AFJSONResponseSerializer serializer];
    //jsonResponse.removesKeysWithNullValues = YES;
    self.networkManager.responseSerializer = jsonResponse;
    
    NSMutableURLRequest *request = [self buildURLRequestWithAction:action withURL:url withParameters:params];
    NSURLSessionDataTask *task = [self executeOperation:request withCompletion:^(id responsedata, ServiceResultInfo *info) { completion(responsedata, info); }];
    
    [task resume];
    return task;
}

- (NSURLSessionDataTask *)operation:(NSString *)action urlResource:(NSString *)url urlParameters:(NSDictionary *)params imgName:(NSString *) name uploadImage:(UIImage *)image actionCompletion:(RESTfulResultHanlder) completion {
    NSMutableURLRequest *request = nil;
    if ([action isEqualToString:OPERATION_IMAGE_DOWNLOAD])
    {
        self.networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.networkManager.responseSerializer = [AFImageResponseSerializer serializer];
        request = [self buildURLRequestWithAction:action withURL:url withParameters:params];
    }
    else if ([action isEqualToString:OPERATION_IMAGE_UPLOAD])
    {
        self.networkManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer *jsonResponse = [AFJSONResponseSerializer serializer];
        jsonResponse.removesKeysWithNullValues = YES;
        self.networkManager.responseSerializer = jsonResponse;
        NSData *imageData = UIImagePNGRepresentation(image);
        request = [self buildURLRequestWithAction:action withURL:url withParameters:params withImgName:name withImageData:imageData];
    }
    
    NSURLSessionDataTask *task = [self executeOperation:request withCompletion:^(id responsedata, ServiceResultInfo *info) {
        completion(responsedata, info);
    }];
    [task resume];
    return task;
}

#pragma mark - Private Methods

- (NSMutableURLRequest *)setRequestHeaders:(NSMutableURLRequest *) request
{
    
//    if ([CoreStore sharedStore].patrolAccessToken.length > 0) {
//    
//        [request setValue:[CoreStore sharedStore].patrolAccessToken forHTTPHeaderField:@"access_token"];
//    }
    return request;
}

- (NSURLSessionDataTask *)executeOperation:(NSMutableURLRequest *)request withCompletion:(RESTfulResultHanlder) completion
{
    NSURLSessionDataTask *dataTask = [self.networkManager dataTaskWithRequest:request
                                                            completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

                                                                BOOL finishStatus = ( (error == nil) && ([[responseObject objectForKey:@"success"] intValue] != 0) );
                                                                ServiceResultInfo *info = [[ServiceResultInfo alloc] initWithHTTPStatusCode:[((NSHTTPURLResponse *)response) statusCode]
                                                                                                                                  errorInfo:error
                                                                                                                            descriptionInfo:[responseObject objectForKey:@"description"]
                                                                                                                                  errorCode:[responseObject objectForKey:@"errorcode"]
                                                                                                                               finishStatus:finishStatus];
                                                                if (!info.finishStatus) {
                                                                    NSLog(@"%@", [request allHTTPHeaderFields]);
                                                                    NSLog(@"%@", [info description]);
                                                                }
                                                                completion(responseObject[@"responsedata"], info);
                                                            }];
    return dataTask;
}

- (NSMutableURLRequest *)buildURLRequestWithAction:(NSString *)action withURL:(NSString *) url withParameters:(NSDictionary *)params
{
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSError *__autoreleasing *error = NULL;
    NSMutableURLRequest *request = [self.networkManager.requestSerializer requestWithMethod:action
                                                                                  URLString:[[NSURL URLWithString:url relativeToURL:self.networkManager.baseURL] absoluteString]
                                                                                 parameters:params
                                                                                      error:(NSError *__autoreleasing *)error];
    return [self setRequestHeaders:request];
}

- (NSMutableURLRequest *)buildURLRequestWithAction:(NSString *) action withURL:(NSString *) url withParameters:(NSDictionary *)params withImgName:(NSString *) name withImageData:(NSData *)imageData {
    NSError *__autoreleasing *error = NULL;
    NSMutableURLRequest *request = [self.networkManager.requestSerializer multipartFormRequestWithMethod:action
                                                                                               URLString:[[NSURL URLWithString:url relativeToURL:self.networkManager.baseURL] absoluteString]
                                                                                              parameters:params
                                                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                   [formData appendPartWithFileData:imageData
                                                                                                               name:name
                                                                                                           fileName:[NSString stringWithFormat:@"%@.png", [[NSUUID UUID] UUIDString]]
                                                                                                           mimeType:@"image/png"];}
                                                                                                   error:(NSError *__autoreleasing *)error];
    
    return [self setRequestHeaders:request];
}

@end
