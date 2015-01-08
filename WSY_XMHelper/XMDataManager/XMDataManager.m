//
//  XMDataManager.m
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import "XMDataManager.h"
#import "XMHelper.h"
#import "XMVideoDownloader.h"
#import "XMDownloadInfo.h"
#import <CoreData+MagicalRecord.h>

typedef NS_ENUM(NSInteger, XMDownloadStatus) {
    XMDownloadStateDownloadNow,
    XMDownloadStateDownloadStop,
};

@interface XMDataManager()
@property (nonatomic, strong) NSMutableArray *downloadSqueue;
@property (nonatomic, assign) XMDownloadStatus downloadStatus;

@end

@implementation XMDataManager
+ (instancetype)defaultDataManager
{
    GCDSharedInstance(^{
        return [[self alloc] init];
    });
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.downloadList = [NSMutableArray new];
        self.downloadNow = [NSMutableDictionary new];
        self.downloadSqueue = [NSMutableArray new];
        self.videoDownloadQuality = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoDownloadQuality"];
        self.downloadStatus = XMDownloadStateDownloadStop;
    }
    return self;
}


- (RACSignal *)requestVideoListWithVideoType: (VIDEO_TYPE)type errorHandler: (void(^)())errorHandle
{
    @weakify(self);
    return [[[XMRequest defaultRequest] fetchJSONFromUrlString:[XMAPI api_videoListWithVideoType:type] errorHandler:^{
        errorHandle();
    }] doNext:^(NSArray *list) {
        @strongify(self);
        self.videoList = list;
    }] ;
}

- (RACSignal *)requestVideoDetailListWithType:(VIDEO_TYPE)type name:(NSString *)name page:(NSInteger)page errorHandler: (void(^)())errorHandle
{
    @weakify(self);
    return [[[XMRequest defaultRequest] fetchJSONFromUrlString:[XMAPI api_seriesWithType:type name:name page:page] errorHandler:^{
        return errorHandle();
    }] doNext:^(NSArray *list) {
        @strongify(self);
        self.detailList = list;
    }];
}

- (void)addVideoDownloadWithVideoDic:(NSDictionary *)videoDic
{
        [self downloader_addDownloadToSqeue:videoDic];
}
- (void)downloader_addDownloadToSqeue: (NSDictionary *)videoDic
{
//    [self xm_addVideoDownloadDicToEntity:videoDic];
    [self xm_addVideoDownloadDicToEntity:videoDic completion:^(XMDownloadInfo *info) {
        [self willChangeValueForKey:@"downloadList"];
        [self.downloadList addObject:videoDic];
        [self didChangeValueForKey:@"downloadList"];
        [self.downloadSqueue addObject:info];
        [self downloader_startDownload];
    }];
    
    
}

- (void)xm_addVideoDownloadDicToEntity: (NSDictionary *)videoDic completion: (void(^)(XMDownloadInfo *info))completion
{
    //@"name": cell.name.text, @"urlString": urlString, @"length":length, @"time": time, @"img": cell.imgString, @"youku_id": cell.youku.youku_id
    
    XMDownloadInfo *info = [XMDownloadInfo MR_createInContext:[NSManagedObjectContext MR_defaultContext]];
    info.name = videoDic[@"name"];
    info.time = videoDic[@"time"];
    info.imgString = videoDic[@"imgString"];
    info.youku_id = videoDic[@"youku_id"];
    info.urlString = videoDic[@"urlString"];
    info.length = videoDic[@"length"];
    info.done = [NSNumber numberWithBool:NO];
    info.addTime = [NSDate date];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            completion(info);
        }
    }];
}


- (void)downloader_startDownload
{
    
    XMDownloadInfo *downloadInfo = [self.downloadSqueue firstObject];
    NSString *videoName = downloadInfo.name;
    NSMutableDictionary *videoInfo = [NSMutableDictionary new];
    
    //开始下载
    if (self.downloadStatus == XMDownloadStateDownloadNow) {
        return;
    }
    self.downloadStatus = XMDownloadStateDownloadNow;
    [[XMVideoDownloader defaultDownloader] downloader_StartDownLoadWithName:downloadInfo.youku_id urlString:downloadInfo.urlString  downloadProgress:^(float progress) {
        NSString *progressString = [NSString stringWithFormat:@"%.2f", progress];
        [videoInfo removeAllObjects];
        [self.downloadNow removeAllObjects];
        [self willChangeValueForKey:@"downloadNow"];
        [videoInfo setValue:progressString forKey:@"progress"];
        [videoInfo setValue:videoName  forKey:@"name"];
        [self.downloadNow setObject:videoInfo forKey:@"download"];
        [self didChangeValueForKey:@"downloadNow"];
    } completionHandler:^{
        downloadInfo.done = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            [self.downloadSqueue removeObject:downloadInfo];
            self.downloadStatus = XMDownloadStateDownloadStop;
            if (self.downloadSqueue.count != 0) {
                [self downloader_startDownload];
            }
        }];
    } failedHandler:^{
        NSLog(@"DownLoadError");
    }];
    
}

- (void)deleteLocalDownloadFileWithFileUUID:(NSString *)uuid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/Downloads/%@", documentsDirectory, uuid];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"error: %@", [error description]);
        }
    }
}

@end
