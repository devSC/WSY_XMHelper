//
//  XMRequest.h
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface XMRequest : NSObject

+ (instancetype)defaultRequest;
-(RACSignal *)fetchJSONFromUrlString: (NSString *)urlString errorHandler: (void(^)())errorHandle;


@end
