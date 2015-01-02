//
//  AppDelegate.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "AppDelegate.h"
#import <HTTPServer.h>
//#import "HTTPServer.h"
#import <UIColor+Expanded.h>

#define MR_ENABLE_ACTIVE_RECORD_LOGGING 0
#import <CoreData+MagicalRecord.h>
#import <MagicalRecord.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
static NSString *const path = @"Downloads";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Create server using our custom MyHTTPServer class
    httpServer = [[HTTPServer alloc] init];
    
    // Tell the server to broadcast its presence via Bonjour.
    // This allows browsers such as Safari to automatically discover our service.
    [httpServer setType:@"_http._tcp."];
    
    // Normally there's no need to run our server on any specific port.
    // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
    // However, for easy testing you may want force a certain port so you can just hit the refresh button.
    [httpServer setPort:12345];
    
    // Serve files from our embedded Web folder
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *webPath = [pathPrefix stringByAppendingPathComponent:path];
    NSLog(@"Setting Root Document: %@", webPath);
    [httpServer setDocumentRoot:webPath];
    //start the httpServer
    
    NSError *error = nil;
    [httpServer start:&error];
    if (error) {
        NSLog(@"HttpServerStartError: %@", [error description]);
    }
//    [MagicalRecord setLogLevel:MagicalRecordLogLevelOff]
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"videoDownloadQuality"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"normal" forKey:@"videoDownloadQuality"];
    }
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"XMHelper.sqlite"];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"E64A19"]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithHexString:@"E64A19"]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                       dictionaryWithObjectsAndKeys: [UIColor colorWithHexString:@"E64A19"],
                                                       NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
//
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
