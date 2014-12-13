//
//  AppDelegate.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTTPServer;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HTTPServer* httpServer;
}
@property (strong, nonatomic) UIWindow *window;


@end

