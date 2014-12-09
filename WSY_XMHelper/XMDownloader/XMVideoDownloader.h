//
//  XMVideoDownloader.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMVideoDownloader : NSObject

+ (XMVideoDownloader *)defaultDownloader;
- (void)downloader_StartDownLoadWithUrlString: (NSString*)urlString failedHandler: (void(^)())failedHandler;


@end
