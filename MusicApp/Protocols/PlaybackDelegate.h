//
//  PlayDelegate.h
//  MusicApp
//
//  Created by mmt on 21/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlaybackDelegate <NSObject>

- (void)sendTrackTitle:(NSString *)title;
- (void)startUpdatingProgressBar;
- (void)stopUpdatingProgressBar;

@end

NS_ASSUME_NONNULL_END
