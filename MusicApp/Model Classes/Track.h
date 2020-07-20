//
//  Track.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"
#import "Album.h"

NS_ASSUME_NONNULL_BEGIN

@interface Track : NSObject

@property (assign) long int trackId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *titleShort;
@property (copy, nonatomic) NSString *titleVersion;
@property (copy, nonatomic) NSString *trackInfoUrl;
@property (assign) int duration;
@property (assign) int rank;
@property (assign) BOOL explicitLyrics;
@property (assign) int explicitContentLyrics;
@property (assign) int explicitContentCover;
@property (copy, nonatomic) NSString *trackUrl;
@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic) Artist *artist;
@property (strong, nonatomic) Album *album;

@end

NS_ASSUME_NONNULL_END
