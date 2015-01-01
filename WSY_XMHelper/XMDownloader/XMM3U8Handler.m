//
//  XMM3U8Handler.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMM3U8Handler.h"
#import <GCDObjC.h>
#import "XMM3U8SegmentInfo.h"
#import "XMM3U8PlayList.h"

static NSString *const formant = @"#EXTINF:";
@implementation XMM3U8Handler

+ (XMM3U8Handler *)defaultHandler
{
    GCDSharedInstance(^{
        return [[self alloc] init];
    });
}

-(void)handler_parseUrlString:(NSString *)urlString uuid:(NSString *)uuid completionHandler:(void (^)(XMM3U8PlayList *))successHandler failedHandler:(void (^)())failedHandler
{
//    NSLog(@"download name: %@  urlString: %@", uuid, urlString);
    NSStringEncoding encoding;
    NSError *error = nil;
    NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] usedEncoding:&encoding error:&error];
    if (dataString == nil) {
        failedHandler();
        return;
    }
    NSMutableArray *m3u8Segments = [NSMutableArray array];
    NSString *remainData = dataString;
    NSRange m3u8SegmentRange = [remainData rangeOfString:@"#EXTINF:"];
    while (m3u8SegmentRange.location != NSNotFound)
    {
        XMM3U8SegmentInfo *segmentInfo = [[XMM3U8SegmentInfo alloc] init];
        //读取片段时长
        NSRange commentRange = [remainData rangeOfString:@","];
        NSString *value = [remainData substringWithRange:NSMakeRange(m3u8SegmentRange.location + [@"#EXTINF:" length], commentRange.location - (m3u8SegmentRange.location + [@"#EXTINF:" length]))];
        segmentInfo.duration = [value intValue];
        
        remainData = [remainData substringFromIndex:commentRange.location];
        //读取片段url
        NSRange linkRangeBegin = [remainData rangeOfString:@"http"];
        NSRange linkRangeEnd = [remainData rangeOfString:@"#"];
        NSString *linkUrl = [remainData substringWithRange:NSMakeRange(linkRangeBegin.location, linkRangeEnd.location - linkRangeBegin.location)];
        segmentInfo.locationUrl = linkUrl;
        
        [m3u8Segments addObject:segmentInfo];
        remainData = [remainData substringFromIndex:linkRangeEnd.location];
        m3u8SegmentRange = [remainData rangeOfString:@"#EXTINF:"];
        }
    
    XMM3U8PlayList *playList = [[XMM3U8PlayList alloc] initWithM3U8Segments:m3u8Segments];
    playList.uuid = uuid;
    successHandler(playList);
    m3u8Segments = nil;
}


/* m3u8文件格式示例
 
 #EXTM3U
 #EXT-X-TARGETDURATION:30
 #EXT-X-VERSION:2
 #EXT-X-DISCONTINUITY
 #EXTINF:10,
 http://f.youku.com/player/getMpegtsPath/st/flv/fileid/03000201004F4BC6AFD0C202E26EEEB41666A0-C93C-D6C9-9FFA-33424A776707/ipad0_0.ts?KM=14eb49fe4969126c6&start=0&end=10&ts=10&html5=1&seg_no=0&seg_time=0
 #EXTINF:20,
 http://f.youku.com/player/getMpegtsPath/st/flv/fileid/03000201004F4BC6AFD0C202E26EEEB41666A0-C93C-D6C9-9FFA-33424A776707/ipad0_1.ts?KM=14eb49fe4969126c6&start=10&end=30&ts=20&html5=1&seg_no=1&seg_time=0
 #EXTINF:20,
 http://f.youku.com/player/getMpegtsPath/st/flv/fileid/03000201004F4BC6AFD0C202E26EEEB41666A0-C93C-D6C9-9FFA-33424A776707/ipad0_2.ts?KM=14eb49fe4969126c6&start=30&end=50&ts=20&html5=1&seg_no=2&seg_time=0
 #EXTINF:20,
 http://f.youku.com/player/getMpegtsPath/st/flv/fileid/03000201004F4BC6AFD0C202E26EEEB41666A0-C93C-D6C9-9FFA-33424A776707/ipad0_3.ts?KM=14eb49fe4969126c6&start=50&end=70&ts=20&html5=1&seg_no=3&seg_time=0
 #EXTINF:24,
 http://f.youku.com/player/getMpegtsPath/st/flv/fileid/03000201004F4BC6AFD0C202E26EEEB41666A0-C93C-D6C9-9FFA-33424A776707/ipad0_4.ts?KM=14eb49fe4969126c6&start=70&end=98&ts=24&html5=1&seg_no=4&seg_time=0
 #EXT-X-ENDLIST
 */

@end
