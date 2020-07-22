//
//  PlaybackController.m
//  MusicApp
//
//  Created by mmt on 21/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "PlaybackController.h"
#import "Track.h"
#import "WebRequestHandler.h"
#import "Constants.h"

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receieveTrack:) name:playTrack object:nil];
    }
    return self;
}

- (void)receieveTrack:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    self.trackList = userInfo[trackList];
    self.currentTrackIndex = [userInfo[currentTrackIndex] intValue];
    
    [self initiatePlayback];
}

- (void)playMusic
{
    [self.audioPlayer play];
}

- (void)pauseMusic
{
    [self.audioPlayer pause];
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
    
    if( [self.delegate respondsToSelector:@selector(sendTrackTitle:)] )
    {
        [self.delegate sendTrackTitle:track.title];
    }
    
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler downloadPlaybackfrom:track.trackUrl completionBlock:^(NSData * _Nonnull playbackData) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self startPlayback:playbackData];
            
        });
    }];
}

- (void)startPlayback:(NSData *)playbackData
{
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:playbackData error:&error];
    self.audioPlayer.delegate = self;
    
    if(error)
    {
        NSLog(@"Error:%@",error.description);
        return;
    }
    
    self.audioPlayer.numberOfLoops = 0;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
    if( [self.delegate respondsToSelector:@selector(startUpdatingProgressBar)] )
    {
        [self.delegate startUpdatingProgressBar];
    }
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
