//
//  XMAPI.h
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
//系列3
//赛事4
//个人2
typedef NS_ENUM(NSInteger, VIDEO_TYPE) {
    VIDEO_TYPE_HERO = 1,
    VIDEO_TYPE_PLAYER,
    VIDEO_TYPE_SERIES,
    VIDEO_TYPE_ORGNIZED,
    VIDEO_TYPE_LATEST,
};


@interface XMAPI : NSObject
+ (NSString *)api_videoListWithVideoType: (VIDEO_TYPE)type;
+ (NSString *)api_seriesWithType: (VIDEO_TYPE)type name: (NSString *)name page: (NSInteger)page;

@end
