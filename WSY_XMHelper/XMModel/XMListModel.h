//
//  XMListModel.h
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import <Mantle.h>
@interface XMListModel : MTLModel<MTLJSONSerializing>
//"id": "13902",
//"img": "http://r4.ykimg.com/054104085482D0116A0A4004D4FF0E56",
//"length": "04:19",
//"name": "[GgWp]每日精彩集锦 第468期：薇恩操作太炫酷 我学不来啊！",
//"time": 1417881599,
//"video_addr
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *video_addr;
@property (nonatomic, strong) NSString *video_addr_high;
@property (nonatomic, strong) NSString *video_addr_super;
@property (nonatomic, strong) NSString *youku_id;


@end
