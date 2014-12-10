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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
