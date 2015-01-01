//
//  XMDetailListController.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//
#import "XMHelper.h"
#import "XMVideoDetailViewModel.h"
#import "XMBaseTableController.h"
@interface XMDetailListController : XMBaseTableController

@property (nonatomic, strong) XMVideoDetailViewModel *viewModel;

- (void)setVideoListType: (VIDEO_TYPE)type name: (NSString *)name videoId: (NSString *)ID;
@end
