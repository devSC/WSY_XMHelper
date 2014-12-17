//
//  WSYDeviceInfo.m
//  WSY_DeviceInfo
//
//  Created by Andou on 14/11/24.
//  Copyright (c) 2014年 SCDev. All rights reserved.
//

#import "WSYDeviceInfo.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@implementation WSYDeviceInfo
+(NSDictionary*)deviceNamesCode {
    
    static NSDictionary* deviceNamesByCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceNamesByCode = @{
                              @"iPhone3,1" :[NSNumber numberWithInteger:iPhone4],
                              @"iPhone4,1" :[NSNumber numberWithInteger:iPhone4S],
                              @"iPhone5,1" :[NSNumber numberWithInteger:iPhone5],
                              @"iPhone5,2" :[NSNumber numberWithInteger:iPhone5],
                              @"iPhone5,3" :[NSNumber numberWithInteger:iPhone5C],
                              @"iPhone5,4" :[NSNumber numberWithInteger:iPhone5C],
                              @"iPhone6,1" :[NSNumber numberWithInteger:iPhone5S],
                              @"iPhone6,2" :[NSNumber numberWithInteger:iPhone5S],
                              @"iPhone7,2" :[NSNumber numberWithInteger:iPhone6],
                              @"iPhone7,1" :[NSNumber numberWithInteger:iPhone6Plus],
                              @"i386"      :[NSNumber numberWithInteger:Simulator],
                              @"x86_64"    :[NSNumber numberWithInteger:Simulator]
                              };
    });
    
    return deviceNamesByCode;
}

+ (NSString *)deviceName{
    return [[UIDevice currentDevice] name];
}

+ (DeviceModel)deviceModel {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    DeviceModel version = (DeviceModel)[[self.deviceNamesCode objectForKey:code] integerValue];
    
    return version;
}
+ (NSString *)deviceSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}
/**
 *  @return infoDictionary
 */
+ (NSDictionary *)infoDictionary{
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)currentShortVersionString{
    return [self.infoDictionary objectForKey:@"CFBundleShortVersionString"];
}
+(DeviceSize)deviceSize {
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight == 480)
        return iPhone35inch;
    else if(screenHeight == 568)
        return iPhone4inch;
    else if(screenHeight == 667)
        return  iPhone47inch;
    else if(screenHeight == 736)
        return iPhone55inch;
    else
        return 0;
}

@end
