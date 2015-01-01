//
//  XMBaseCollectionController.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMBaseCollectionController : UICollectionViewController

- (void)addHeaderRefreshView;
- (void)addFooterMoreView;


- (void)startRefreshHeader;
- (void)startRefreshFooter;

@end
