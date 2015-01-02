//
//  XMVideoListViewModel.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMAPI.h"

@class RACSignal;
typedef NS_ENUM(NSInteger, XMVideoListSegmentedChart) {
    XMVideoListSegmentedChartPlayer,
    XMVideoListSegmentedChartSeries,
    XMVideoListSegmentedChartOrignized,
};
@interface XMVideoListViewModel : NSObject
{
    NSArray *_videoList;
}
@property (nonatomic, assign) VIDEO_TYPE type;

@property (nonatomic, assign) XMVideoListSegmentedChart selectedChart;
@property (nonatomic, strong) NSArray *videoList;


- (instancetype)init;

- (RACSignal *)fetchObjectWithErrorHandler: (void(^)())errorHandle;
- (RACSignal *)refreshObjectWithErrorHandler: (void(^)())errorHandle;

@end
