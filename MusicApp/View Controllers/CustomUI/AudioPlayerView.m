//
//  AudioPlayerView.m
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AudioPlayerView.h"

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
        [self.playButton setImage:[UIImage imageNamed:@"playImage"] forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];
        self.playButton.enabled = NO;
        [self addSubview:self.playButton];
        
        self.pauseButton = [[UIButton alloc] init];
        [self.pauseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.pauseButton setImage:[UIImage imageNamed:@"pauseImage"] forState:UIControlStateNormal];
        [self.pauseButton addTarget:self action:@selector(pauseMusic) forControlEvents:UIControlEventTouchUpInside];
        self.pauseButton.enabled = NO;
        [self addSubview:self.pauseButton];
        
        self.fastForwardButton = [[UIButton alloc] init];
        [self.fastForwardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.fastForwardButton setImage:[UIImage imageNamed:@"fastforwardImage"] forState:UIControlStateNormal];
        [self.fastForwardButton addTarget:self action:@selector(forwardMusic) forControlEvents:UIControlEventTouchUpInside];
        self.fastForwardButton.enabled = NO;
        [self addSubview:self.fastForwardButton];
        
        self.rewindButton = [[UIButton alloc] init];
        [self.rewindButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.rewindButton setImage:[UIImage imageNamed:@"rewindImage"] forState:UIControlStateNormal];
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
        
        self.trackList = [[NSArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receieveTrack:) name:@"PlayTrack" object:nil];
    }
    
    return self;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{@"superView":self, @"titleLabel":self.titleLabel, @"playButton":self.playButton, @"pauseButton":self.pauseButton, @"fastForwardButton":self.fastForwardButton, @"rewindButton":self.rewindButton, @"progressView":self.progressView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]-10-[playButton(40)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pauseButton(==playButton)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fastForwardButton(==playButton)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rewindButton(==playButton)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[titleLabel]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playButton(40)]-10-[pauseButton(==playButton)]-10-[progressView]-10-[rewindButton(==playButton)]-10-[fastForwardButton(==playButton)]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
    
}

- (void)receieveTrack:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    self.trackList = userInfo[@"trackList"];
    self.currentTrackIndex = [userInfo[@"currentTrackIndex"] intValue];
    
    [self initiatePlayback];
}

- (void)playMusic
{
    [self.audioPlayer play];
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
}

- (void)pauseMusic
{
    [self.audioPlayer pause];
    [self.timer invalidate];
    self.playButton.enabled = YES;
    self.pauseButton.enabled = NO;
}

- (void)forwardMusic
{
    self.audioPlayer.currentTime += 5;
    
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
}

- (void)rewindMusic
{
    self.progressView.progress = 0.0;
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
    
    if((self.progressView.progress == 0.0) && (self.currentTrackIndex > 0))
    {
        self.currentTrackIndex -= 1;
    }
    
    [self initiatePlayback];
}

- (void)updateProgress
{
    float normalizedTime = (float)((double)self.audioPlayer.currentTime / ((double)self.audioPlayer.duration));
    self.progressView.progress = normalizedTime;
    
    if(self.progressView.progress >= 1)
    {
        [self.timer invalidate];
    }
}

- (void)initiatePlayback
{
    Track *track = self.trackList[self.currentTrackIndex];
    self.titleLabel.text = track.title;
    NSURL *url = [NSURL URLWithString:track.trackUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
    self.audioPlayer.delegate = self;
    
    
    if(error)
    {
        NSLog(@"Error:%@",error.description);
    }

    self.audioPlayer.numberOfLoops = 0;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
    self.fastForwardButton.enabled = YES;
    self.rewindButton.enabled = YES;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress) userInfo:nil repeats:true];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.currentTrackIndex += 1;
    
    if(self.currentTrackIndex < self.trackList.count)
    {
        [self initiatePlayback];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
