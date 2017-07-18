//
//  Device.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "Device.h"
#import <sys/utsname.h>

@import MobileCoreServices;

#define SYSTEM_VERSION_EQUAL_TO(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation Device

+ (NSString *) getCurrentDeviceSysVer{
    return [[UIDevice currentDevice] systemVersion];
}

+ (BOOL) currentDeviceSysVerEqual:(NSString *)version{
    return SYSTEM_VERSION_EQUAL_TO(version);
}

+ (BOOL) currentDeviceSysVerGreater:(NSString *)version{
    return SYSTEM_VERSION_GREATER_THAN(version);
}

+ (BOOL) currentDeviceSysVerGreaterOrEqual:(NSString *)version{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version);
}

+ (BOOL) currentDeviceSysVerLess:(NSString *)version{
    return SYSTEM_VERSION_LESS_THAN(version);
}

+ (BOOL) currentDeviceSysVerLessOrEqual:(NSString *)version{
    return SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version);
}

+ (NSString *) getCurrentDeviceName{
    return [[UIDevice currentDevice] name];
}

+ (NSString *) getCurrentDeviceModel{
    return [[UIDevice currentDevice] model];
}

+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

+ (DeviceScreenCategory) currentDeviceScreen {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //its iPhone. Find out which one?
        //        SmallestScreenDevice,               // 3.5
        //        SmallerScreenDevice,                // 4.0
        //        BiggerScreenDevice,                 // 4.7
        //        BiggestScreenDevice,                // 5.5
        
        CGRect result = [UIScreen mainScreen].nativeBounds;
        if(result.size.height == 960.f)
        {
            return SmallestScreenDevice;
        }
        else if(result.size.height == 1136.f)
        {
            return SmallerScreenDevice;
        }
        else if(result.size.height == 1334.f)
        {
            return BiggerScreenDevice;
        }
        else if(result.size.height == 2208.f)
        {
            return BiggestScreenDevice;
        }
        else {
            return UndefineSrceenDevice;
        }
    }
    else {
        return UndefineSrceenDevice;
    }
}


@end
