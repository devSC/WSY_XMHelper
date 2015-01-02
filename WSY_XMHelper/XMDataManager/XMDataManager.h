//
//  XMDataManager.h
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMAPI.h"

@class RACSignal;
@interface XMDataManager : NSObject

@property (nonatomic, strong) NSArray *videoList;
@property (nonatomic, strong) NSArray *detailList;
@property (nonatomic, strong) NSMutableArray *downloadList;
@property (nonatomic, strong) NSMutableDictionary *downloadNow;
@property (nonatomic, assign) NSString *videoDownloadQuality;


+ (instancetype)defaultDataManager;

- (RACSignal *)requestVideoListWithVideoType: (VIDEO_TYPE)type errorHandler: (void(^)())errorHandle;
- (RACSignal *)requestVideoDetailListWithType: (VIDEO_TYPE)type name: (NSString *)name page: (NSInteger)page errorHandler: (void(^)())errorHandle;
//download
- (void)addVideoDownloadWithVideoDic: (NSDictionary *)videoDic;
- (void)deleteLocalDownloadFileWithFileUUID: (NSString *)uuid;

@end

//@protocol XMVideoDownloadDelegate <NSObject>
//
//- (void)xmVideoDownloadSetProgress: (float)progress withInfo: (NSDictionary *)info;
//
//@end