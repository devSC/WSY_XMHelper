//
//  XMM3U8Handler.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMM3U8PlayList;
@interface XMM3U8Handler : NSObject

+ (XMM3U8Handler *)defaultHandler;
- (void)handler_parseUrlString: (NSString *)urlString uuid: (NSString *)uuid completionHandler: (void(^)(XMM3U8PlayList *playList))successHandler failedHandler: (void(^)())failedHandler;


@end
