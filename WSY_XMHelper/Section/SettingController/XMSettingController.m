//
//  XMSettingController.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/2.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "XMSettingController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <UIAlertView+BlocksKit.h>

@interface XMSettingController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *qualitySegment;

@end

@implementation XMSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *videoQuality = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoDownloadQuality"];
    if ([videoQuality isEqualToString:@"normal"]) {
        [self.qualitySegment setSelectedSegmentIndex:0];
    }else if ([videoQuality isEqualToString:@"high"]) {
        [self.qualitySegment setSelectedSegmentIndex:1];
    }else {
        [self.qualitySegment setSelectedSegmentIndex:2];
    }
    
}
- (IBAction)segmentControlTouched:(id)sender {
    UISegmentedControl *segmented = sender;
    switch (segmented.selectedSegmentIndex) {
        case 0:{
            [[NSUserDefaults standardUserDefaults] setObject:@"normal" forKey:@"videoDownloadQuality"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }break;
        case 1: {
            [[NSUserDefaults standardUserDefaults] setObject:@"high" forKey:@"videoDownloadQuality"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }break;
        case 2: {
            [[NSUserDefaults standardUserDefaults] setObject:@"super" forKey:@"videoDownloadQuality"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NSString * path = [NSHomeDirectory() stringByAppendingString:@"/Documents/Downloads"];
        NSDictionary * dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        NSString *cashSize = dict[NSFileSize];
        UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:[NSString stringWithFormat:@"已缓存%@M, 确定删除缓存? ", cashSize]];
        [alert bk_addButtonWithTitle:@"确定" handler:^{
            for (NSString *fieName in files) {
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", path, fieName] error:nil];
            }
        }];
    }
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
