//
//  XMYouKuModel.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMYouKuModel.h"

@implementation XMYouKuModel
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setModelData:(NSDictionary *)data
{
//    self.video_addr = [self getCorrentUrlString: [data objectForKey:@"video_addr"]];
//    self.video_addr_high = [self getCorrentUrlString:[data objectForKey:@"video_addr_high"]];
//    self.video_addr_super = [self getCorrentUrlString:[data objectForKey:@"video_addr_super"]];
    self.videoUrlDic = @{@"normal": [self getCorrentUrlString: [data objectForKey:@"video_addr"]], @"high": [self getCorrentUrlString:[data objectForKey:@"video_addr_high"]], @"super": [self getCorrentUrlString:[data objectForKey:@"video_addr_super"]]};
    self.youku_id = [data objectForKey:@"youku_id"];
}

- (NSString *)getCorrentUrlString: (NSString *)string
{
    NSString *urlString = string;
    NSArray *array = [string componentsSeparatedByString:@"%"];
    urlString = nil;
    for (NSString *string in array) {
        NSString *newString = string;
        if ([string hasPrefix:@"25"]) {
            newString = [string substringWithRange:NSMakeRange(2, string.length -2)];
        }
        if (!urlString) {
            urlString = newString;
        }else{
            urlString = [NSString stringWithFormat:@"%@%%%@",urlString, newString];
        }
    }
    return urlString;
}

@end
