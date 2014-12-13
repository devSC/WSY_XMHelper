//
//  XMDownloadListController.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/10.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMDownloadListController.h"
#import "XMDownloadCell.h"
#import "XMHelper.h"
#import "XMDataManager.h"
#import "XMVideoDownloader.h"
#import <MediaPlayer/MediaPlayer.h>
#import <UIColor+Expanded.h>

@interface XMDownloadListController ()
{
    NSMutableArray *_listArray;
}
@property (nonatomic, strong) NSMutableArray *listArray;



@end

@implementation XMDownloadListController
@synthesize listArray = _listArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithHexString:@"2F438B"]];
    
    self.tableView.estimatedRowHeight = 129.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    [[XMDataManager defaultDataManager] setDelegate:self];
    
    @weakify(self);
    [[RACObserve([XMDataManager defaultDataManager], downloadList) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSMutableArray *list){
        @strongify(self);
        self.listArray = list;
        [self.tableView reloadData];
//        [self startDownload];
    }];
    [[RACObserve([XMDataManager defaultDataManager], downloadNow) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSMutableDictionary *downloadNow) {
        @strongify(self);
        NSDictionary *downloadInfo = downloadNow[@"download"];
        NSString *videoName = downloadInfo[@"name"];
        NSArray *visiableCell = self.tableView.visibleCells;
        for (XMDownloadCell *cell in visiableCell) {
            if ([cell.name.text isEqualToString:videoName]) {
                CGFloat progress = [downloadInfo[@"progress"] floatValue];
                [cell.progressLabel setText:[NSString stringWithFormat:@"%%%.0f", progress*100]];
                cell.progressView.progress = progress;
                break;
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMDownloadCell" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setCellData:[self.listArray objectAtIndex:indexPath.row]];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMDownloadCell *cell =(XMDownloadCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.progressView.progress == 1) {
        NSString *urlString = [NSString stringWithFormat:@"http://127.0.0.1:12345/%@/movie.m3u8", cell.youku.youku_id];
//        urlString = @"http://127.0.0.1:12345/movie1/movie.m3u8";
        NSURL *url = [NSURL URLWithString:urlString];
        MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:player];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
