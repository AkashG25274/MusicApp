//
//  Playlist.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist

- (id)initWith:(NSString *)title imageUrl:(NSString *)imageUrl andTrackListURL:(NSString *)trackListUrl
{
    self = [super init];
    
    if(self)
    {
        self.title = title;
        self.imageUrl = imageUrl;
        self.trackListUrl = trackListUrl;
    }
    
    return self;
}

@end
