//
//  XMDetailCell.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMDetailCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface XMDetailCell ()
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *length;

@end
@implementation XMDetailCell

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
