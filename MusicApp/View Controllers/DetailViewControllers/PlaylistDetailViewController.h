//
//  PlaylistDetailViewController.h
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playlist.h"
#import "TrackDetailsDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaylistDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TrackDetailsDelegate>

@property (strong, nonatomic) Playlist *playlist;

@end

NS_ASSUME_NONNULL_END
