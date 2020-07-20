//
//  TrackTabViewController.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Protocols/TrackDetailsDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrackViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TrackDetailsDelegate>

@property (copy, nonatomic) NSString *trackURL;

@end

NS_ASSUME_NONNULL_END
