//
//  XMDetailListController.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHelper.h"
#import "XMVideoDetailViewModel.h"
@interface XMDetailListController : UITableViewController

@property (nonatomic, strong) XMVideoDetailViewModel *viewModel;

- (void)setVideoListType: (VIDEO_TYPE)type name: (NSString *)name videoId: (NSString *)ID;
@end
