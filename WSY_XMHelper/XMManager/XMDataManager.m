//
//  XMDataManager.m
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import "XMDataManager.h"
#import "XMHelper.h"

@implementation XMDataManager
+ (instancetype)defaultDataManager
{
    GCDSharedInstance(^{
        return [[self alloc] init];
    });
}

- (void)xm_videoListWithVideoType: (VIDEO_TYPE)type
{
    [[[XMRequest defaultRequest] fetchJSONFromUrlString:[XMAPI api_videoListWithVideoType:type]] subscribeNext:^(NSArray *list) {
        self.videoList = list;
    }];
}
- (void)xm_detailListWithType:(VIDEO_TYPE)type name:(NSString *)name page:(NSInteger)page
{
    [[[XMRequest defaultRequest] fetchJSONFromUrlString:[XMAPI api_seriesWithType:type name:name page:page]] subscribeNext:^(NSArray *list) {
        self.detailList = list;
    }];
}

/*
- (void)xm_origanizedVideoList
{
    [[[XMRequest defaultRequest] fetchJSONFromUrlString:[XMAPI api_orgnizedVideoList]] subscribeNext:^(NSArray *list) {
        self.videoList = list;
    }];
}
- (void)xm_seriesVideoList
{
    [[[XMRequest defaultRequest] fetchJSONFromUrlString:[XMAPI api_seriesVideoList]] subscribeNext:^(NSArray *list) {
        self.videoList = list;
    }];
}
- (void)xm_singlerVideoList
{
    [[[XMRequest defaultRequest] fetchJSONFromUrlString:[XMAPI api_singlerVideoList]] subscribeNext:^(NSArray *list) {
        self.videoList = list;
    }];
}
 */

@end
