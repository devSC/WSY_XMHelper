//
//  TQTableViewCellRemoveController.h
//  TQTableViewCellRemoveController
//
//  Created by qfu on 8/11/14.
//  Copyright (c) 2014 qfu. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TQTableViewCellRemoveControllerDelegate <NSObject>

- (void)didRemoveTableViewCellWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface TQTableViewCellRemoveController : NSObject

@property (weak) id<TQTableViewCellRemoveControllerDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end
