//
//  XMDownloadCell.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/10.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMDownloadCell.h"
#import <UIImageView+WebCache.h>
#import "XMVideoDownloader.h"
#import "XMDownloadInfo.h"
#import <CoreData+MagicalRecord.h>
@implementation XMDownloadCell
- (void)awakeFromNib {
    // Initialization code
    
    [_backGroundView.layer setCornerRadius:5.0f];
    [_backGroundView.layer setMasksToBounds:YES];
}
- (void)setCellData:(NSDictionary *)data
{
    [_icon sd_setImageWithURL:[NSURL URLWithString:[data objectForKey:@"img"]]];
    _name.text = [data objectForKey:@"name"];
    _time.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"time"]];
    _length.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"length"]];
    _youku = [[XMYouKuModel alloc] init];
    [_youku setModelData:data];
}
- (void)setCellInfo:(XMDownloadInfo *)info
{
    self.info = info;
    [_icon sd_setImageWithURL:[NSURL URLWithString:info.imgString]];
    _name.text = info.name;
    _time.text = info.time;
    if (info.done.boolValue) {
        [self.progressView setHidden:YES];
        [self.progressLabel setHidden:YES];
        self.time.hidden = NO;
        self.length.hidden = NO;
        [self.length setText:info.length];
        self.time.text = @"下载完成";
    }
}
- (void)setDownloadProgress:(float)progress
{
    [self.progressLabel setText:[NSString stringWithFormat:@"%%%.0f", progress*100]];
    self.progressView.progress = progress;
    if (progress == 1) {
        self.info.done = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
