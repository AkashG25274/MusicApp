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

@interface TrackTabViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TrackDetailsDelegate>

@end

NS_ASSUME_NONNULL_END
