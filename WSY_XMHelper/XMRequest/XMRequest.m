//
//  XMRequest.m
//  WSY_LOLHelper
//
//  Created by 袁仕崇 on 14/12/6.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import "XMRequest.h"
#import <GCDObjC.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface XMRequest ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation XMRequest

+(instancetype)defaultRequest
{
    GCDSharedInstance(^{
        return [[self alloc] init];
    })
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}
- (RACSignal *)fetchJSONFromUrlString:(NSString *)urlString errorHandler: (void(^)())errorHandle
{
    //创建信号
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        //创建sessionDataTask /task 工作 任务/ 来请求数据 为异步的
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    //如果没有错误,将JSON数据发送给用户
                    [subscriber sendNext:json];
                    [subscriber sendCompleted];
                }else {
                    [subscriber sendError:jsonError];
                }
            }else {
                [subscriber sendError:error];
            }
            //无论请求成功与失败都要让用户知道请求已经完成
            [subscriber sendCompleted];
        }];
        //一旦有调用此方法,就启动网络请求
        [dataTask resume];
        //4.创建并返回RACDisposable对象来清理已经被销毁的信号
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"fetchJSONFromUrlStringError: %@", error);
        return errorHandle(error);
    }];
}
@end








