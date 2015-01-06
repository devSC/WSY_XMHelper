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
#import "XMVideoDownloader.h"
#import <UIColor+Expanded.h>
#import "WSYDeviceInfo.h"

#import <UIScrollView+UzysAnimatedGifPullToRefresh.h>

#import "XMVideoListViewModel.h"
#import "XMVideoDetailViewModel.h"

@interface XMVideoListController ()<UICollectionViewDelegateFlowLayout>
{
    NSArray *_videoList;
}
@property (nonatomic, assign) VIDEO_TYPE type;

@property (nonatomic, strong) NSArray *videoList;
@property (nonatomic, strong) NSString *shouldRefresh;

@property (weak, nonatomic) IBOutlet UISegmentedControl *videoTypeSegmented;
@property (nonatomic, strong) XMVideoListViewModel *viewModel;
@end

@implementation XMVideoListController
@synthesize videoList = _videoList;


static NSString * const reuseIdentifier = @"VideoListCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.collectionView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg-cloth"]];
    
    self.viewModel = [[XMVideoListViewModel alloc] init];
    
    RAC(self.viewModel, selectedChart) = [self.videoTypeSegmented rac_newSelectedSegmentIndexChannelWithNilValue:nil];

    [self addHeaderRefreshView];
    
    RACSignal *refreshSignal = [self rac_signalForSelector:@selector(startRefreshHeader)];
    RACSignal *viewAppelSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    RACSignal *segmentedChangedSignal = [self.videoTypeSegmented rac_signalForControlEvents:UIControlEventValueChanged];
    @weakify(self);
    [[[segmentedChangedSignal flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self.viewModel fetchObjectWithErrorHandler:^{
            [self.collectionView stopRefreshAnimation];
        }];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    [[[[RACSignal merge:@[viewAppelSignal,refreshSignal]] flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self.viewModel fetchObjectWithErrorHandler:^{
            [self.collectionView stopRefreshAnimation];
        }];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
        [self.collectionView stopRefreshAnimation];
    } error:^(NSError *error) {
        [self.collectionView stopRefreshAnimation];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
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
    return self.viewModel.videoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMVideoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setCellData:[self.viewModel.videoList objectAtIndex:indexPath.row]];
    // Configure the cell
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    XMVideoListCell *cell = (XMVideoListCell *)sender;
    if ([segue.identifier isEqualToString:@"XMDetail"]) {
        XMDetailListController *detailsViewController =  segue.destinationViewController;
        detailsViewController.viewModel = [XMVideoDetailViewModel detailViewModelWithVideoListType:self.viewModel.type name:cell.name.text videoId:cell.videoId];
    }
}
#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([WSYDeviceInfo deviceSize] == iPhone4inch || [WSYDeviceInfo deviceSize] == iPhone35inch) {
        return CGSizeMake(90, 100);
    }
    return CGSizeMake(110, 130);
}
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
