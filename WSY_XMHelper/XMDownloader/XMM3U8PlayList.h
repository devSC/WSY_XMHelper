//
//  XMM3U8PlayList.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/9.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMM3U8SegmentInfo.h"

@interface XMM3U8PlayList : NSObject
{
    NSMutableArray *_m3u8Segments;
    NSInteger _length;
    NSString *_uuid;
}
@property (strong, nonatomic) NSMutableArray *m3u8Segments;
@property (assign, nonatomic) NSInteger length;
@property (copy, nonatomic) NSString *uuid;
- (id)initWithM3U8Segments: (NSMutableArray *)segments;
- (XMM3U8SegmentInfo *)list_getSegment: (NSInteger)index;

@end
