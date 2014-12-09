//
//  XMM3U8PlayList.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMM3U8PlayList.h"

@implementation XMM3U8PlayList

@synthesize m3u8Segments = _m3u8Segments;
@synthesize length = _length;
@synthesize uuid = _uuid;

- (id)initWithM3U8Segments:(NSMutableArray *)segments
{
    self = [super init];
    if (self) {
        self.m3u8Segments = segments;
        self.length = [segments count];
    }
    return self;
}
- (XMM3U8SegmentInfo *)list_getSegment:(NSInteger)index
{
    if (index >= 0 && index < self.length) {
        return (XMM3U8SegmentInfo *)[self.m3u8Segments objectAtIndex:index];
    }
    return nil;
}

@end
