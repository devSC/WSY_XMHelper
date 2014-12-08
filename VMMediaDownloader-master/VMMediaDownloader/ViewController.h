//
//  ViewController.h
//  VMMediaDownloader
//
//  Created by Sun Peng on 11/6/14.
//  Copyright (c) 2014 Peng Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoDownloader.h"

@class MPMoviePlayerViewController;
@interface ViewController : UIViewController <VideoDownloadDelegate> {
    VideoDownloader *_downloader;
}


@end

