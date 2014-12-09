//
//  XMM3U8SegmentDownloader.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "ASIHTTPRequest.h"
typedef enum {
    E_RUNNING = 0,
    E_STOPPED = 1,
}E_TASK_STATUS;
@class XMM3U8SegmentDownloader;

typedef void(^progressBlock) (CGFloat progress);
typedef void(^completionBlock) (XMM3U8SegmentDownloader *downloader);
@interface XMM3U8SegmentDownloader : NSObject<ASIProgressDelegate, ASIHTTPRequestDelegate>
{
    float _sgProgress;
    E_TASK_STATUS _status;
    NSString *_filePath;
    NSString *_fileName;
    NSString *_tmpFileName;
    NSString *_downloadUrlString;
    
    AFHTTPRequestOperation *request;
}
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *tmpFileName;
@property (nonatomic, copy) NSString *downloadUrlString;
@property (nonatomic, assign) float sgProgress;
@property (nonatomic, assign) E_TASK_STATUS status;

@property (nonatomic, copy) progressBlock myProgress;
@property (nonatomic, copy) completionBlock myCompletion;


- (id)initWithUrlString: (NSString *)urlString filePath: (NSString *)filePath fileName: (NSString *)fileName;
- (void)startWitProgress: (progressBlock)progress completion: (completionBlock)completion;

@end
