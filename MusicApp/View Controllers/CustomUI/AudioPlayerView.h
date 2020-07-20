//
//  AudioPlayerView.h
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioPlayerView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIButton *fastForwardButton;
@property (strong, nonatomic) UIButton *rewindButton;
@property (strong, nonatomic) UIProgressView *progressView;

- (void)setUpConstraints;

@end

NS_ASSUME_NONNULL_END
