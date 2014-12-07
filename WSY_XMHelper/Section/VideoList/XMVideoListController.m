//
//  VideoListController.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMVideoListController.h"
#import "XMVideoListCell.h"
#import "XMHelper.h"
#import "XMDataManager.h"
#import "XMDetailListController.h"
@interface XMVideoListController ()
{
    NSArray *_videoList;
}
@property (nonatomic, assign) VIDEO_TYPE type;

@property (nonatomic, strong) NSArray *videoList;
@end

@implementation XMVideoListController
@synthesize videoList = _videoList;


static NSString * const reuseIdentifier = @"VideoListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    self.type = VIDEO_TYPE_PLAYER;
    [[XMDataManager defaultDataManager] xm_videoListWithVideoType:_type];
    @weakify(self);
    [[RACObserve([XMDataManager defaultDataManager], videoList) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *listArray) {
        @strongify(self);
        self.videoList = listArray;
        [self.collectionView reloadData];
    }];
    
}
- (IBAction)segmentDidPressed:(UISegmentedControl *)sender {
    self.type = (sender.selectedSegmentIndex +2);
    [[XMDataManager defaultDataManager] xm_videoListWithVideoType:_type];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _videoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMVideoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setCellData:[_videoList objectAtIndex:indexPath.row]];
    // Configure the cell
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    XMVideoListCell *cell = (XMVideoListCell *)sender;
    if ([segue.identifier isEqualToString:@"XMDetail"]) {
        XMDetailListController *detailsViewController =  segue.destinationViewController;
        [detailsViewController setVideoListType:_type name:cell.videoId];
    }
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
