//
//  XMVideoListViewModel.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "XMVideoListViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XMDataManager.h"

@implementation XMVideoListViewModel
@synthesize videoList = _videoList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = VIDEO_TYPE_PLAYER;
        RAC(self, type) = [RACObserve(self, selectedChart) map:^id(NSNumber *chart) {
            return @(chart.integerValue +2);
        }];
    }
    return self;
}
- (RACSignal *)fetchObject
{
    return [[[XMDataManager defaultDataManager] requestVideoListWithVideoType:self.type] doNext:^(NSArray *videoArray) {
        self.videoList = videoArray;
    }];
}
@end
