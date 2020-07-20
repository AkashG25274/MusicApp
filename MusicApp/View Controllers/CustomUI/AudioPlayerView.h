//
//  AudioPlayerView.h
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Track.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioPlayerView : UIView <AVAudioPlayerDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIButton *fastForwardButton;
@property (strong, nonatomic) UIButton *rewindButton;
@property (strong, nonatomic) UIProgressView *progressView;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSArray *trackList;
@property (assign) int currentTrackIndex;
@property (strong, nonatomic) NSTimer *timer;

- (void)setUpConstraints;

@end

NS_ASSUME_NONNULL_END
