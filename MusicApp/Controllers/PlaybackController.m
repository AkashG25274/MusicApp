//
//  PlaybackController.m
//  MusicApp
//
//  Created by mmt on 21/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "PlaybackController.h"
#import "Track.h"

@implementation PlaybackController

+ (id)sharedHandler
{
    static PlaybackController *playbackController = nil;
    
    @synchronized (self) {
        
        if( playbackController == nil )
        {
            playbackController = [[PlaybackController alloc] init];
        }
    }
    
    return playbackController;
}

- (id)init
{
    self = [super init];
    
    if( self )
    {
        self.trackList = [[NSArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receieveTrack:) name:@"PlayTrack" object:nil];
    }
    return self;
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
//    [self startTimer];
    if( [self.delegate respondsToSelector:@selector(startUpdatingProgressBar)] )
    {
        [self.delegate startUpdatingProgressBar];
    }
}

- (void)pauseMusic
{
    [self.audioPlayer pause];
    [self stopTimer];
}

- (void)forwardMusic
{
    self.audioPlayer.currentTime += 5;
}

- (BOOL)musicJustStarted
{
    if(self.audioPlayer.currentTime <= 5)
    {
        return YES;
    }
    
    return NO;
}

- (float)getNormalizedTime
{
    float normalizedTime = (float)((double)self.audioPlayer.currentTime / ((double)self.audioPlayer.duration));
    return normalizedTime;
}

- (void)initiatePlayback
{
    Track *track = self.trackList[self.currentTrackIndex];
//    self.titleLabel.text = track.title;
    
    if( [self.delegate respondsToSelector:@selector(sendTrackTitle:)] )
    {
        [self.delegate sendTrackTitle:track.title];
    }
    
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
    
    if( [self.delegate respondsToSelector:@selector(startUpdatingProgressBar)] )
    {
        [self.delegate startUpdatingProgressBar];
    }
    
//    [self startTimer];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self proceedToNextSong];
}

- (void)proceedToNextSong
{
    self.currentTrackIndex += 1;
    
    if(self.currentTrackIndex == self.trackList.count)
    {
        self.currentTrackIndex = 0;
    }
    
    [self initiatePlayback];
}

- (void)proceedToPreviousSong
{
    if(self.currentTrackIndex == 0)
    {
        self.currentTrackIndex = (int)self.trackList.count -1;
    }
    else
    {
        self.currentTrackIndex -= 1;
    }
    
    [self initiatePlayback];
}

//- (void)startTimer
//{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress) userInfo:nil repeats:true];
//}
//
//- (void)stopTimer
//{
//    if(self.timer.isValid)
//    {
//        [self.timer invalidate];
//    }
//}



@end
