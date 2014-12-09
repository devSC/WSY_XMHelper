//
//  XMM3U8SegmentInfo.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMM3U8SegmentInfo.h"

@implementation XMM3U8SegmentInfo

@synthesize locationUrl = _locationUrl;
@synthesize duration = _duration;
- (void)dealloc
{
    self.locationUrl = nil;
}

@end
