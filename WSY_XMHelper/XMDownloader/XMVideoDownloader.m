//
//  XMVideoDownloader.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMVideoDownloader.h"
#import <GCDObjC/GCDObjC.h>
#import "XMM3U8Handler.h"
#import "XMM3U8PlayList.h"
#import "XMM3U8SegmentInfo.h"
#import "XMM3U8SegmentDownloader.h"

@interface XMVideoDownloader ()
{
    NSMutableArray *_downloadArray;
    XMM3U8PlayList *_playList;
    float _totalProgress;
    BOOL bDownLoading;
    CGFloat _totleNumber;
}
@property (nonatomic, strong) NSMutableArray *downloadArray;
@property (nonatomic, strong) XMM3U8PlayList *playList;
@property (nonatomic, assign) float totalProgress;


@end;

static NSString *const path = @"Downloads";
@implementation XMVideoDownloader

@synthesize downloadArray = _downloadArray;
@synthesize playList = _playList;
@synthesize totalProgress = _totalProgress;


+ (XMVideoDownloader *)defaultDownloader
{
    GCDSharedInstance(^{
        return [[self alloc] init];
    })
}

- (void)downloader_StartDownLoadWithName:(NSString *)name urlString:(NSString *)urlString downloadProgress:(void (^)(float))progress completionHandler:(void (^)())completionHandler failedHandler:(void (^)())failedHandler
{
    
    NSString *uuid = name;
    [[XMM3U8Handler defaultHandler] handler_parseUrlString:urlString uuid:uuid completionHandler:^(XMM3U8PlayList *playList) {
        self.downloadArray = [NSMutableArray array];
        self.playList = playList;
        
        //start download video
        for (int i = 0; i < playList.length; i++) {
            NSString *fileName = [NSString stringWithFormat:@"id%d",i];
            XMM3U8SegmentInfo *segmentInfo = [playList list_getSegment:i];
            XMM3U8SegmentDownloader *sgDownloader = [[XMM3U8SegmentDownloader alloc] initWithUrlString:segmentInfo.locationUrl filePath:playList.uuid fileName:fileName];
            [self.downloadArray addObject:sgDownloader];
        }
        bDownLoading = YES;
        _totleNumber = self.downloadArray.count;
        for (XMM3U8SegmentDownloader *downloader in self.downloadArray)
        {
            [downloader startWitProgress:^(CGFloat progress) {
                
                
            } completion:^(XMM3U8SegmentDownloader *downloader) {
                
                [self.downloadArray removeObject:downloader];
                CGFloat totleProgress= (_totleNumber - self.downloadArray.count)/_totleNumber;
                progress(totleProgress);
                if (totleProgress == 1) {
                    [self downloader_creatLocalM3U8fileWithPlist:self.playList completionHelper:^{
                        completionHandler();
                    }];
                }
            }];
        }
    } failedHandler:^{
        failedHandler();
    }];
}

- (void)downloader_creatLocalM3U8fileWithPlist: (XMM3U8PlayList *)playList completionHelper: (void (^)())completionHelper
{
#if 0
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *saveTo = [[pathPrefix stringByAppendingPathComponent:path] stringByAppendingPathComponent:playList.uuid];
    NSString *fullPath = [saveTo stringByAppendingPathComponent:@"movie.m3u8"];
    
//    NSLog(@"creat Local M3U8 file path: %@", fullPath);
    
    //创建文件头部
    NSString *head = @"#EXTM3U\n#EXT-X-TARGETDURATION:30\n#EXT-X-VERSION:2\n#EXT-X-DISCONTINUITY\n";
    //
    NSString *segmentPrefix = [NSString stringWithFormat:@"http://127.0.0.1:12345/%@/", playList.uuid];
    for (int i = 0; i < playList.length; i++) {
        
        NSString *fileName = [NSString stringWithFormat:@"id%d", i];
        XMM3U8SegmentInfo *segInfo = [playList list_getSegment:i];
        NSString *length = [NSString stringWithFormat:@"#EXTINF:%ld,\n",(long)segInfo.duration];
        NSString *url = [segmentPrefix stringByAppendingString:fileName];
        head = [NSString stringWithFormat:@"%@%@%@\n", head, length, url];
        
    }
    //创建文件尾部
    NSString *end = @"#EXT-X-ENDLIST";
    head = [head stringByAppendingString:end];
    NSMutableData *writer = [[NSMutableData alloc] init];
    [writer appendData:[head dataUsingEncoding:NSUTF8StringEncoding]];
    
    BOOL bSuccess = [writer writeToFile:fullPath atomically:YES];
    if (bSuccess) {
//        NSLog(@"create m3u8 file success; \n fullpath: %@ \n head: %@", fullPath, head);
        completionHelper();
    }else{
        NSLog(@"create m3u8 file failed");
    }
#else
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *saveTo = [[pathPrefix stringByAppendingPathComponent:path] stringByAppendingPathComponent:playList.uuid];
    NSString *fullpath = [saveTo stringByAppendingPathComponent:@"movie.m3u8"];
//    NSLog(@"createLocalM3U8file:%@",fullpath);
    
    //创建文件头部
    NSString* head = @"#EXTM3U\n#EXT-X-TARGETDURATION:30\n#EXT-X-VERSION:2\n#EXT-X-DISCONTINUITY\n";
    
    NSString* segmentPrefix = [NSString stringWithFormat:@"http://127.0.0.1:12345/%@/",playList.uuid];
    //填充片段数据
    for(int i = 0;i<playList.length;i++)
    {
        NSString* filename = [NSString stringWithFormat:@"id%d",i];
        XMM3U8SegmentInfo* segInfo = [playList list_getSegment:i];
        NSString* length = [NSString stringWithFormat:@"#EXTINF:%ld,\n",(long)segInfo.duration];
        NSString* url = [segmentPrefix stringByAppendingString:filename];
        head = [NSString stringWithFormat:@"%@%@%@\n",head,length,url];
    }
    //创建尾部
    NSString* end = @"#EXT-X-ENDLIST";
    head = [head stringByAppendingString:end];
    NSMutableData *writer = [[NSMutableData alloc] init];
    [writer appendData:[head dataUsingEncoding:NSUTF8StringEncoding]];
    
    BOOL bSucc =[writer writeToFile:fullpath atomically:YES];
    if(bSucc)
    {
//        NSLog(@"create m3u8file succeed; fullpath:%@, content:%@",fullpath,head);
        completionHelper();
    }
    else
    {
        NSLog(@"create m3u8file failed");
    }
#endif
    
}

@end
