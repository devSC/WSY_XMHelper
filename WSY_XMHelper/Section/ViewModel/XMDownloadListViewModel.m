//
//  XMDownloadListViewModel.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "XMDownloadListViewModel.h"
#import "XMDownloadInfo.h"

#import "XMDataManager.h"

#import <CoreData+MagicalRecord.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface XMDownloadListViewModel()
{
    NSMutableArray *_listArray;
}
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end


@implementation XMDownloadListViewModel
@synthesize listArray = _listArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.updateContentSignal = [[RACSubject subject] setNameWithFormat:@"XMDownloadListViewModel updatedContentSignal"];
        self.fetchedResultsController = [self getDownloadList];
        @weakify(self);
        [RACObserve([XMDataManager defaultDataManager], downloadList) subscribeNext:^(NSMutableArray *list){
            @strongify(self);
            self.listArray = list;
            self.fetchedResultsController = [self getDownloadList];
            [(RACSubject *)self.updateContentSignal  sendNext:nil];
        }];
    }
    return self;
}
- (NSFetchedResultsController *)getDownloadList
{
    NSFetchedResultsController *fetchController = [XMDownloadInfo MR_fetchAllGroupedBy:@"name" withPredicate:nil sortedBy:@"addTime" ascending:YES];
    return fetchController;
}

- (NSInteger)numberOfSections
{
    if ([[self.fetchedResultsController sections] count]) {
        return self.fetchedResultsController.sections.count;
    }
    return 0;
}
- (NSInteger)numberOfItemInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo>fetchedSectionInfo = [self.fetchedResultsController sections][section];
    return [fetchedSectionInfo numberOfObjects];
}
- (XMDownloadInfo *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath
{
    self.fetchedResultsController = [self getDownloadList];
}
@end
