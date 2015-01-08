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
#import <ReactiveCocoa/RACEXTScope.h>
@interface XMVideoListViewModel()

@property (strong, nonatomic) NSMutableDictionary *cacheDictionary;

@end

@implementation XMVideoListViewModel
@synthesize videoList = _videoList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cacheDictionary = [NSMutableDictionary new];
        self.type = VIDEO_TYPE_PLAYER;
        RAC(self, type) = [RACObserve(self, selectedChart) map:^id(NSNumber *chart) {
            return @(chart.integerValue +2);
        }];
    }
    return self;
}

- (RACSignal *)fetchObjectWithErrorHandler: (void(^)())errorHandle;
{
    @weakify(self);
    if (self.cacheDictionary[@(self.type)]) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            self.videoList = self.cacheDictionary[@(self.type)];
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }else {
        return [self refreshObjectWithErrorHandler:^{
            errorHandle();
        }];
    }
}

- (RACSignal *)refreshObjectWithErrorHandler: (void(^)())errorHandle
{
    @weakify(self);
    return [[[XMDataManager defaultDataManager] requestVideoListWithVideoType:self.type errorHandler:^{
        errorHandle();
    }] doNext:^(NSArray *videoArray) {
        @strongify(self);
        self.videoList = videoArray;
        //add cache
        [self.cacheDictionary setObject:videoArray forKey:@(self.type)];
    }];
}

@end
