//
//  Device.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//iPhone 6 Plus   736x414 points  2208x1242 pixels    3x scale    1920x1080 physical pixels   401 physical ppi    5.5
//iPhone 6        667x375 points  1334x750 pixels     2x scale    1334x750 physical pixels    326 physical ppi    4.7
//iPhone 5        568x320 points  1136x640 pixels     2x scale    1136x640 physical pixels    326 physical ppi    4.0
//iPhone 4        480x320 points  960x640 pixels      2x scale    960x640 physical pixels     326 physical ppi    3.5
//iPhone 3GS      480x320 points  480x320 pixels      1x scale    480x320 physical pixels     163 physical ppi    3.5


typedef NS_ENUM(NSUInteger, DeviceScreenCategory) {
    SmallestScreenDevice,               // 3.5
    SmallerScreenDevice,                // 4.0
    BiggerScreenDevice,                 // 4.7
    BiggestScreenDevice,                // 5.5
    UndefineSrceenDevice,               // Srceen size
};


@interface Device : NSObject

//iOS system version
+ (NSString *) getCurrentDeviceSysVer; // e.g. @"2.0" "3.2.1"

+ (BOOL) currentDeviceSysVerEqual:(NSString *) version;

+ (BOOL) currentDeviceSysVerGreater:(NSString *)version;

+ (BOOL) currentDeviceSysVerGreaterOrEqual:(NSString *)version;

+ (BOOL) currentDeviceSysVerLess:(NSString *)version;

+ (BOOL) currentDeviceSysVerLessOrEqual:(NSString *)version;


//Device info
+ (NSString *) getCurrentDeviceName; // e.g. "My iPhone"

+ (NSString *) getCurrentDeviceModel; // e.g. @"iPhone", @"iPod Touch"

//Camera
+ (BOOL) isCameraAvailable;
+ (BOOL) isRearCameraAvailable;
+ (BOOL) isFrontCameraAvailable;
+ (BOOL) doesCameraSupportTakingPhotos;
+ (BOOL) isPhotoLibraryAvailable;
+ (BOOL) canUserPickVideosFromPhotoLibrary;
+ (BOOL) canUserPickPhotosFromPhotoLibrary;
+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;

//Device screen size category

+ (DeviceScreenCategory) currentDeviceScreen;

@end
