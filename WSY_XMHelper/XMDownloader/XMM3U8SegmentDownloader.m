//
//  XMM3U8SegmentDownloader.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMM3U8SegmentDownloader.h"


#define kTextDownloadingFileSuffix @"_etc"
static NSString *const path = @"Downloads";

@implementation XMM3U8SegmentDownloader
@synthesize fileName = _fileName, tmpFileName= _tmpFileName,
                    downloadUrlString = _downloadUrlString, status = _status, sgProgress = _sgProgress;

- (id)initWithUrlString:(NSString *)urlString filePath:(NSString *)filePath fileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        self.downloadUrlString = urlString;
        self.fileName = fileName;
        self.filePath = filePath;
        
        NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *saveTo = [[pathPrefix stringByAppendingPathComponent:path] stringByAppendingPathComponent:self.filePath];
        NSString *downloadingFileName = [[NSString alloc] initWithString:[saveTo stringByAppendingPathComponent:[fileName stringByAppendingString:kTextDownloadingFileSuffix]]];
        self.tmpFileName = downloadingFileName;
        
        BOOL isDir = NO;
        if (!([[NSFileManager defaultManager] fileExistsAtPath:saveTo isDirectory:&isDir] && isDir)) {
            [[NSFileManager defaultManager] createDirectoryAtPath:saveTo withIntermediateDirectories:YES attributes:nil error:nil];
        }
        self.progress = 0.0f;
        self.status = E_STOPPED;
    }
    return self;
}


- (void)start
{
#if 0
   AFHTTPRequestOperation *httpOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.downloadUrlString]]];
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *saveTo = [[pathPrefix stringByAppendingPathComponent:path] stringByAppendingPathComponent:self.filePath];
    
    httpOperation.outputStream = [NSOutputStream outputStreamToFileAtPath:[saveTo stringByAppendingPathComponent:self.fileName] append:YES];
    [httpOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        float progress = ((float)totalBytesRead + bytesRead) / (totalBytesExpectedToRead + bytesRead);
        NSLog(@"AFProgress: %.4f", progress);
    }];
    [httpOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AFHTTPRequestOperation Error:%@", [error description]);
    }];
    [httpOperation start];
#else
    NSLog(@"download segment start, fileName = %@,url = %@",self.fileName,self.downloadUrlString);
  
      ASIHTTPRequest *asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[self.downloadUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [asiRequest setTemporaryFileDownloadPath: self.tmpFileName];
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *saveTo = [[pathPrefix stringByAppendingPathComponent:path] stringByAppendingPathComponent:self.filePath];
    [asiRequest setDownloadDestinationPath:[saveTo stringByAppendingPathComponent:self.fileName]];
    [asiRequest setDelegate:self];
    [asiRequest setDownloadProgressDelegate:self];
    asiRequest.allowResumeForFileDownloads = YES;
    [asiRequest setNumberOfTimesToRetryOnTimeout:2];
    [asiRequest startAsynchronous];
    
    self.status = E_RUNNING;
    
    
#endif
}
- (void)startWitProgress:(progressBlock)progress completion:(completionBlock)completion
{
//    NSLog(@"download segment start, fileName = %@,url = %@",self.fileName,self.downloadUrlString);
    self.myProgress = progress;
    self.myCompletion = completion;

    
    ASIHTTPRequest *asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[self.downloadUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [asiRequest setTemporaryFileDownloadPath: self.tmpFileName];
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *saveTo = [[pathPrefix stringByAppendingPathComponent:path] stringByAppendingPathComponent:self.filePath];
    [asiRequest setDownloadDestinationPath:[saveTo stringByAppendingPathComponent:self.fileName]];
    [asiRequest setDelegate:self];
    [asiRequest setDownloadProgressDelegate:self];
    asiRequest.allowResumeForFileDownloads = YES;
    [asiRequest setNumberOfTimesToRetryOnTimeout:2];
    [asiRequest startAsynchronous];
    
    self.status = E_RUNNING;
    }

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    _myCompletion(self);
}
- (void)setProgress:(float)progress
{
    if (progress) {
        _myProgress (progress);
    }
}



@end











