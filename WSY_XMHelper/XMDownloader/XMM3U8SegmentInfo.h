//
//  XMM3U8SegmentInfo.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMM3U8SegmentInfo : NSObject
{
    NSInteger _duration;
    NSString *_locationUrl;
}

@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, copy) NSString *locationUrl;
@end
