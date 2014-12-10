//
//  XMDataManager.h
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMAPI.h"
@interface XMDataManager : NSObject
@property (nonatomic, strong) NSArray *videoList;
@property (nonatomic, strong) NSArray *detailList;
@property (nonatomic, strong) NSMutableArray *downloadList;

+ (instancetype)defaultDataManager;
/**
 *  赛事
 */
- (void)xm_videoListWithVideoType: (VIDEO_TYPE)type;
- (void)xm_detailListWithType: (VIDEO_TYPE)type name: (NSString *)name page: (NSInteger)page;

@end
