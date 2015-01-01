//
//  NSDate+Helper.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

+ (NSString *)confromTimeWithTimeInterverString: (NSString *)interverString
{
    NSTimeInterval interver = interverString.integerValue;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:interver];
    NSString *string = [[confromTimesp description] substringWithRange:NSMakeRange(0, 10)];
    return string;
}
@end
    