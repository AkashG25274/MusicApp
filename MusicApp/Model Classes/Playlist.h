//
//  Playlist.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Playlist : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *trackListUrl;

- (id)initWith:(NSString *)title imageUrl:(NSString *)imageUrl andTrackListURL:(NSString *)trackListUrl;

@end

NS_ASSUME_NONNULL_END
