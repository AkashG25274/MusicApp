//
//  AlbumDetailViewController.h
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import "MusicDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlbumDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MusicDelegate>

@property (strong, nonatomic) Album *album;

@end

NS_ASSUME_NONNULL_END
