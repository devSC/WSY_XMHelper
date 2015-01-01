//
//  XMDetailListController.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 14/12/7.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "XMDetailListController.h"
#import "XMDataManager.h"
#import "XMDetailCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <UIAlertView+BlocksKit.h>
#import "QBPopupMenu.h"
#import <UIScrollView+UzysAnimatedGifPullToRefresh.h>

@interface XMDetailListController ()
@property (nonatomic, strong) QBPopupMenu *popupMenu;

@end

static NSString *const cellIdentifier = @"XMDetailCell";
@implementation XMDetailListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[XMVideoDetailViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 110.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton

//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self
    self.title = self.viewModel.name;
    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshActionHandler:^{
        [weakSelf startRefresh];
    } ProgressImagesGifName:@"spinner_dropbox@2x.gif"
                             LoadingImagesGifName:@"jgr@2x.gif"
                          ProgressScrollThreshold:60 LoadingImageFrameRate:30];
    
    RACSignal *viewWillApperSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    RACSignal *refreshSignal = [self rac_signalForSelector:@selector(startRefresh)];
    
    @weakify(self);
    [[[[RACSignal merge:@[viewWillApperSignal, refreshSignal]] flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self.viewModel fetchObject];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView stopRefreshAnimation];
        [self.tableView reloadData];
    }];
    
    
}
- (void)startRefresh
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.viewModel.detailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setCellData:[self.viewModel.detailList objectAtIndex:indexPath.row]];
    
    return cell;
}
- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        TSTableViewCell *cell = (TSTableViewCell *)recognizer.view;

        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMDetailCell *cell = (XMDetailCell *)[tableView cellForRowAtIndexPath:indexPath];

//    [cell becomeFirstResponder];
//
//    
//    UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"Flag"action:@selector(flag:)];
//    UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"Approve"action:@selector(approve:)];
//    UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"Deny"action:@selector(deny:)];
//    
//    
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    
//    [menu setMenuItems:[NSArray arrayWithObjects:flag, approve, deny, nil]];
//    
//    [menu setTargetRect:cell.frame inView:cell.superview];
//    
//    [menu setMenuVisible:YES animated:YES];
//    
//    return;
    
//    NSLog(@"%@", NSStringFromCGRect(cell.frame));
//    CGRect menuRect = cell.frame;
//    menuRect.origin.y -= tableView.contentOffset.y;
//    menuRect.origin.y += 50;
//    [self.popupMenu showInView:self.view targetRect:menuRect animated:YES];
//    return;
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"选择操作"];
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"下载", @"下载") handler:^{
        NSString *urlString = cell.youku.video_addr;
//        NSString *name = cell.name.text;
        NSString *length = cell.length.text;
        NSString *time = cell.time.text;
        NSDictionary *dic = @{@"name": cell.name.text, @"urlString": urlString, @"length":length, @"time": time, @"imgString": cell.imgString, @"youku_id": cell.youku.youku_id};
        [[XMDataManager defaultDataManager] addVideoDownloadWithVideoDic:dic];
    }];
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"播放", nil) handler:^{
        NSString *urlString = cell.youku.video_addr_super;
        MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlString]];
        [self.navigationController presentMoviePlayerViewControllerAnimated:player];
    }];
    [alertView bk_addButtonWithTitle:@"取消" handler:^{
        
    }];
    [alertView show];
   
}

- (QBPopupMenu *)popupMenu
{
    QBPopupMenuItem *bItem = [QBPopupMenuItem itemWithTitle:@"Hello" actionBlcok:^{
        NSLog(@"Hello");
    }];
    QBPopupMenuItem *bItem2 = [QBPopupMenuItem itemWithTitle:@"Cut" actionBlcok:^{
        NSLog(@"Cut");
    }];
    QBPopupMenuItem *bItem3 = [QBPopupMenuItem itemWithTitle:@"Copy" actionBlcok:^{
        NSLog(@"Copy");
    }];
    QBPopupMenuItem *bItem4 = [QBPopupMenuItem itemWithTitle:@"Delete" actionBlcok:^{
        NSLog(@"Delete");
    }];
    QBPopupMenuItem *bItem5 = [QBPopupMenuItem itemWithImage:[UIImage imageNamed:@"clip"] actionBlock:^{
        NSLog(@"Clip Image");
    }];
    QBPopupMenuItem *bItem6 = [QBPopupMenuItem itemWithTitle:@"Delete" image:[UIImage imageNamed:@"trash"] actionBlcok:^{
        NSLog(@"Trash Image");
    }];
    NSArray *bItems = @[bItem, bItem2, bItem3, bItem4, bItem5, bItem6];
    
    QBPopupMenu *popupMenuBlcok = [[QBPopupMenu alloc] initWithItems:bItems];
    popupMenuBlcok.arrowDirection = QBPopupMenuArrowDirectionDown;
    popupMenuBlcok.highlightedColor = [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
    return popupMenuBlcok;
}



//urlString	NSString *	@"http://pl.youku.com/playlist/m3u8?ep=eiaVHUmPUM0H5ybZiz8bbnnrciJeXJZ0vEiG%2FKYXSsVAMezQkT%2FRww%3D%3D&sid=8417026372563129e96ea&token=8104&ctype=12&ev=1&type=hd2&keyframe=0&oip=1931225911&ts=hXGJ9zRFKHwyRBt2AcC-SLQ&vid=XNzg3MDEzNTI4"	0x00007fb84bc9f910
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
