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

@property (assign) long int playlistId;
@property (copy, nonatomic) NSString *title;
@property (assign) BOOL publicPlaylist;
@property (assign) int totalTracks;
@property (copy, nonatomic) NSString *playlistInfoUrl;
@property (copy, nonatomic) NSString *pictureUrl;
@property (copy, nonatomic) NSString *smallPictureUrl;
@property (copy, nonatomic) NSString *mediumPictureUrl;
@property (copy, nonatomic) NSString *bigPictureUrl;
@property (copy, nonatomic) NSString *xlPictureUrl;
@property (copy, nonatomic) NSString *checksum;
@property (strong, nonatomic) NSString *trackListUrl;
@property (strong, nonatomic) NSString *creationDate;
@property (copy, nonatomic) NSString *type;

//- (id)initWith:(NSString *)title imageUrl:(NSString *)imageUrl andTrackListURL:(NSString *)trackListUrl;

@end

NS_ASSUME_NONNULL_END
