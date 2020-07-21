//
//  TrackCustomTableCell.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Protocols/MusicDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrackCustomTableCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *artistNameLabel;
@property (strong, nonatomic) UIButton *optionsButton;
@property (strong, nonatomic) id <MusicDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
