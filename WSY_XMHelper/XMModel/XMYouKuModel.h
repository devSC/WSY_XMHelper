//
//  XMYouKuModel.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMYouKuModel : NSObject
@property (nonatomic, strong) NSDictionary *videoUrlDic;
@property (nonatomic, copy) NSString *video_addr;
@property (nonatomic, copy) NSString *video_addr_high;
@property (nonatomic, copy) NSString *video_addr_super;
@property (nonatomic, copy) NSString *youku_id;

- (void)setModelData: (NSDictionary *)data;

@end
