//
//  XMDownloadInfo.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/14.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface XMDownloadInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * length;
@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) id img;
@property (nonatomic, retain) NSString * imgString;
@property (nonatomic, retain) NSString * youku_id;
@property (nonatomic, retain) NSString * urlString;

@end
