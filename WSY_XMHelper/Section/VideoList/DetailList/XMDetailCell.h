//
//  XMDetailCell.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMYouKuModel.h"
@interface XMDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *length;
@property (nonatomic, strong) XMYouKuModel *youku;
@property (nonatomic, strong) NSString *imgString;
- (void)setCellData: (NSDictionary *)data;

@end
