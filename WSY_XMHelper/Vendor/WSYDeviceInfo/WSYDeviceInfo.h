//
//  WSYDeviceInfo.h
//  WSY_DeviceInfo
//
//  Created by Andou on 14/11/24.
//  Copyright (c) 2014年 SCDev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DeviceModel){
    iPhone4 = 3,
    iPhone4S = 4,
    iPhone5 = 5,
    iPhone5C = 5,
    iPhone5S = 6,
    iPhone6 = 7,
    iPhone6Plus = 8,
    Simulator = 0
};
typedef NS_ENUM(NSInteger, DeviceSize){
    iPhone35inch = 1,
    iPhone4inch = 2,
    iPhone47inch = 3,
    iPhone55inch = 4
};

@interface WSYDeviceInfo : NSObject

+ (NSString *)deviceName;
/**
 *
 *  @return eg:iPhone4 iPhone5s ..
 */
+ (DeviceModel)deviceModel;


+ (NSString *)deviceSystemVersion;
/**
 *  @return infoDictionary
 */
+ (NSDictionary *)infoDictionary;

+ (NSString *)currentShortVersionString;
+(DeviceSize)deviceSize;

@end
