//
//  HeaderView.h
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArtistPlaylistHeaderView : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *textLabel;

- (void)setUpConstraints;

@end

NS_ASSUME_NONNULL_END
