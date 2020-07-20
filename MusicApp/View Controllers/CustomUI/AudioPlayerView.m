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
        self.playButton.titleLabel.textColor = UIColor.blackColor;
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
        [self addSubview:self.playButton];
        
        self.pauseButton = [[UIButton alloc] init];
        [self.pauseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.pauseButton.titleLabel.textColor = UIColor.blackColor;
        [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self addSubview:self.pauseButton];
        
        self.fastForwardButton = [[UIButton alloc] init];
        [self.fastForwardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.fastForwardButton.titleLabel.textColor = UIColor.blackColor;
        [self.fastForwardButton setTitle:@"Forward" forState:UIControlStateNormal];
        [self addSubview:self.fastForwardButton];
        
        self.rewindButton = [[UIButton alloc] init];
        [self.rewindButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.rewindButton.titleLabel.textColor = UIColor.blackColor;
        [self.rewindButton setTitle:@"Rewind" forState:UIControlStateNormal];
        [self addSubview:self.rewindButton];
        
        self.progressView = [[UIProgressView alloc] init];
        [self.progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.progressView setProgressViewStyle:UIProgressViewStyleBar];
        [self.progressView setProgress:0.5f animated:YES];
        self.progressView.tintColor = UIColor.blueColor;
        self.progressView.trackTintColor = UIColor.lightGrayColor;
        [self addSubview: self.progressView];
    }
    
    return self;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{@"superView":self, @"titleLabel":self.titleLabel, @"playButton":self.playButton, @"pauseButton":self.pauseButton, @"fastForwardButton":self.fastForwardButton, @"rewindButton":self.rewindButton, @"progressView":self.progressView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]-10-[playButton]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[titleLabel]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playButton]-10-[pauseButton]-10-[progressView(50)]-10-[rewindButton]-10-[fastForwardButton]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
}

@end
