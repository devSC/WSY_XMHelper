//
//  XMAPI.m
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import "XMAPI.h"

@implementation XMAPI

+ (NSString *)api_videoListWithVideoType: (VIDEO_TYPE)type
{
    NSInteger arc = arc4random()%1000000 +100000;
    if (type == VIDEO_TYPE_LATEST) {
        NSString *string = [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/videolist_99.json?r=%ld", (long)arc];
        return string;
    }
    NSString *string = [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/videotype_%ld.json?r=%ld", (long)type, (long)arc];
    return string;
}

+ (NSString *)api_seriesWithType: (VIDEO_TYPE)type name: (NSString *)name page: (NSInteger)page
{
    NSInteger arc = arc4random()%1000000 +100000;
    NSString *string = [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/video/videolist_%ld_%@_%ld.json?r=%ld",(long)type, name, (long)page, (long)arc];
    return string;
}

@end
