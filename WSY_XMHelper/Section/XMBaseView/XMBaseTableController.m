//
//  XMBaseTableController.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "XMBaseTableController.h"
#import <UIScrollView+UzysAnimatedGifPullToRefresh.h>
#import "MJRefresh.h"

@interface XMBaseTableController ()

@end

@implementation XMBaseTableController

- (void)addHeaderRefreshView
{
    __weak typeof(self) weakSelf =self;
    [self.tableView addPullToRefreshActionHandler:^{
        [weakSelf startRefreshHeader];
    } ProgressImagesGifName:@"spinner_dropbox@2x.gif"
                                  LoadingImagesGifName:@"jgr@2x.gif"
                               ProgressScrollThreshold:60
                                 LoadingImageFrameRate:30];
}
- (void)addFooterMoreView
{
    __weak typeof(self) weakSelf =self;
    [self.tableView addFooterWithCallback:^{
        [weakSelf startRefreshFooter];
    }];

}
- (void)startRefreshHeader
{
    
}

- (void)startRefreshFooter
{
    
}



@end
