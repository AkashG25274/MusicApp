//
//  AudioPlayerView.h
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"
#import "PlaybackController.h"
#import "PlaybackDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioPlayerView : UIView <PlaybackDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIButton *fastForwardButton;
@property (strong, nonatomic) UIButton *rewindButton;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) PlaybackController *playbackController;

- (void)setUpConstraints;

@end

NS_ASSUME_NONNULL_END
