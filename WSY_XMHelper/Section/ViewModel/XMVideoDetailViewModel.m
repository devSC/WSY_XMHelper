//
//  XMVideoDetailViewModel.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "XMVideoDetailViewModel.h"
#import "XMDataManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>


@implementation XMVideoDetailViewModel

+ (instancetype)detailViewModelWithVideoListType:(VIDEO_TYPE)type name:(NSString *)name videoId:(NSString *)ID
{
    return [[self alloc] initDetailViewModelWithVideoListType:type name:name videoId:ID];
}
- (instancetype)initDetailViewModelWithVideoListType:(VIDEO_TYPE)type name:(NSString *)name videoId:(NSString *)ID
{
    self = [super init];
    if (self) {
        self.type = type;
        self.name = name;
        self.ID = ID;
        self.page = 1;
    }
    return self;
}
- (NSMutableArray *)detailList
{
    if (_detailList == nil) {
        _detailList = [NSMutableArray new];
    }
    return _detailList;
}
- (RACSignal *)fetchObjectWithErrorHandler: (void(^)())errorHandle
{
    @weakify(self);
    return [[[XMDataManager defaultDataManager] requestVideoDetailListWithType:_type name:_ID page:_page errorHandler:^{
        errorHandle();
    }] doNext:^(NSArray *list) {
        @strongify(self);
        [self.detailList removeAllObjects];
        [self.detailList addObjectsFromArray:list];
    }];
}
- (RACSignal *)fetchMoreObjectWithErrorHandler: (void(^)())errorHandle
{
    @weakify(self);
    if (self.detailList.count <20) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }
    return [[[XMDataManager defaultDataManager] requestVideoDetailListWithType:self.type name:self.ID page:self.page errorHandler:^{
        return errorHandle();
    }] doNext:^(NSArray *list) {
        @strongify(self);
        if ([self.detailList containsObject:list.firstObject]) {
            return;
        }
        [self.detailList addObjectsFromArray:list];
    }];
}
-(NSInteger)page
{
    return (_page +1);
}
@end
