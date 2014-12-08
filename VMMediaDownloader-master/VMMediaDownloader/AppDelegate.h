//
//  AppDelegate.h
//  VMMediaDownloader
//
//  Created by Sun Peng on 11/6/14.
//  Copyright (c) 2014 Peng Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTTPServer;
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    HTTPServer* httpServer;
}

@property (strong, nonatomic) UIWindow *window;


@end

