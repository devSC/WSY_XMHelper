//
//  XMVideoDetailViewModel.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMAPI.h"

@class RACSignal;
@interface XMVideoDetailViewModel : NSObject
@property (nonatomic, assign) VIDEO_TYPE type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSMutableArray *detailList;


+ (instancetype)detailViewModelWithVideoListType:(VIDEO_TYPE)type name:(NSString *)name videoId:(NSString *)ID;

- (RACSignal *)fetchObjectWithErrorHandler: (void(^)())errorHandle;
- (RACSignal *)fetchMoreObjectWithErrorHandler: (void(^)())errorHandle;


@end
