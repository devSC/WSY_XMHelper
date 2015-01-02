//
//  VideoListCell.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMVideoListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <GCDObjC.h>

@implementation XMVideoListCell

- (void)awakeFromNib
{
    [self.backGroundView.layer setCornerRadius:5.0f];
//    [self.backGroundView.layer setBorderWidth:1.0f];
//    [self.backGroundView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.backGroundView.layer setMasksToBounds:YES];
}
- (void)setCellData:(NSDictionary *)data
{
    [_icon sd_setImageWithURL:[NSURL URLWithString:[data objectForKey:@"img"]]];
    _name.text = [data objectForKey:@"name"];
    _videoId = [data objectForKey:@"id"];
    _name.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"name"]];
}


@end
