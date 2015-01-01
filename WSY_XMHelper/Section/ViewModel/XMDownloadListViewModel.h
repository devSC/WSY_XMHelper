//
//  XMDownloadListViewModel.h
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData+MagicalRecord.h>
@class RACSignal;
@class XMDownloadInfo;
@interface XMDownloadListViewModel : NSObject

@property (nonatomic, strong) RACSignal *updateContentSignal;


- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemInSection: (NSInteger)section;
- (XMDownloadInfo *)itemAtIndexPath: (NSIndexPath *)indexPath;
-(void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;

@end
