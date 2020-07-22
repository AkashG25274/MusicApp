//
//  AudioPlayerView.m
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AudioPlayerView.h"
#import "Constants.h"

@implementation AudioPlayerView

- (id)init
{
    self = [super init];
    
    if(self)
    {
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        self.titleLabel.text = @"Title";
        [self addSubview:self.titleLabel];
        
        self.playButton = [[UIButton alloc] init];
        [self.playButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.playButton setImage:[UIImage imageNamed:playImage] forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];
        self.playButton.enabled = NO;
        [self addSubview:self.playButton];
        
        self.pauseButton = [[UIButton alloc] init];
        [self.pauseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.pauseButton setImage:[UIImage imageNamed:pauseImage] forState:UIControlStateNormal];
        [self.pauseButton addTarget:self action:@selector(pauseMusic) forControlEvents:UIControlEventTouchUpInside];
        self.pauseButton.enabled = NO;
        [self addSubview:self.pauseButton];
        
        self.fastForwardButton = [[UIButton alloc] init];
        [self.fastForwardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.fastForwardButton setImage:[UIImage imageNamed:fastForwardImage] forState:UIControlStateNormal];
        [self.fastForwardButton addTarget:self action:@selector(forwardMusic) forControlEvents:UIControlEventTouchUpInside];
        self.fastForwardButton.enabled = NO;
        [self addSubview:self.fastForwardButton];
        
        self.rewindButton = [[UIButton alloc] init];
        [self.rewindButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.rewindButton setImage:[UIImage imageNamed:rewindImage] forState:UIControlStateNormal];
        [self.rewindButton addTarget:self action:@selector(rewindMusic) forControlEvents:UIControlEventTouchUpInside];
        self.rewindButton.enabled = NO;
        [self addSubview:self.rewindButton];
        
        self.progressView = [[UIProgressView alloc] init];
        [self.progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.progressView setProgressViewStyle:UIProgressViewStyleBar];
        [self.progressView setProgress:0.0f animated:YES];
        self.progressView.tintColor = UIColor.blueColor;
        self.progressView.trackTintColor = UIColor.lightGrayColor;
        [self addSubview: self.progressView];
        
        self.playbackController = [PlaybackController sharedHandler];
        self.playbackController.delegate = self;
    }
    
    return self;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{superView:self, titleLabel:self.titleLabel, playButton:self.playButton, pauseButton:self.pauseButton, fastForwardButton:self.fastForwardButton, rewindButton:self.rewindButton, progressView:self.progressView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]-10-[playButton(40)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pauseButton(==playButton)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fastForwardButton(==playButton)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rewindButton(==playButton)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[titleLabel]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playButton(40)]-10-[pauseButton(==playButton)]-10-[progressView]-10-[rewindButton(==playButton)]-10-[fastForwardButton(==playButton)]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
    
}

#pragma mark <PlayDelegate>

- (void)sendTrackTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)startUpdatingProgressBar
{
    [self startTimer];
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
    self.fastForwardButton.enabled = YES;
    self.rewindButton.enabled = YES;
}

- (void)stopUpdatingProgressBar
{
    [self stopTimer];
}

- (void)playMusic
{
    [self.playbackController playMusic];
    [self startTimer];
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
}

- (void)pauseMusic
{
    [self.playbackController pauseMusic];
    [self stopTimer];
    self.playButton.enabled = YES;
    self.pauseButton.enabled = NO;
}

- (void)forwardMusic
{
    [self.playbackController forwardMusic];
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
}

- (void)rewindMusic
{
    if( [self.playbackController musicJustStarted] )
    {
        self.progressView.progress = 0;
        [self.playbackController proceedToPreviousSong];
    }
    else
    {
        self.progressView.progress = 0.0;
        [self.playbackController initiatePlayback];
    }
    
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
}

- (void)updateProgress
{
    float normalizedTime = [self.playbackController getNormalizedTime];
    
    self.progressView.progress = normalizedTime;
    
    if(self.progressView.progress >= 1)
    {
        self.progressView.progress = 0;
        [self.playbackController proceedToNextSong];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.playbackController proceedToNextSong];
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress) userInfo:nil repeats:true];
}

- (void)stopTimer
{
    if(self.timer.isValid)
    {
        [self.timer invalidate];
    }
}

@end
