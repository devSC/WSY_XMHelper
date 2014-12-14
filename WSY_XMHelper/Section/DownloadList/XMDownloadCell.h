//
//  XMDownloadCell.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/10.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMYouKuModel.h"
@class XMDownloadInfo;
@interface XMDownloadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *length;
@property (strong, nonatomic) XMYouKuModel *youku;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (nonatomic, strong) XMDownloadInfo *info;

@property (strong, nonatomic) NSString *videoId;
- (void)setCellData: (NSDictionary *)data;
- (void)setCellInfo: (XMDownloadInfo *)info;
- (void)setDownloadProgress: (float)progress;
@end
