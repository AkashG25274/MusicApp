//
//  PlaybackController.h
//  MusicApp
//
//  Created by mmt on 21/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "PlaybackDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaybackController : NSObject <AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSArray *trackList;
@property (assign) int currentTrackIndex;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) id <PlaybackDelegate> delegate;

+ (id)sharedHandler;
- (void)playMusic;
- (void)pauseMusic;
- (void)forwardMusic;
- (BOOL)musicJustStarted;
- (void)proceedToPreviousSong;
- (void)proceedToNextSong;
- (float)getNormalizedTime;
- (void)initiatePlayback;

@end

NS_ASSUME_NONNULL_END
