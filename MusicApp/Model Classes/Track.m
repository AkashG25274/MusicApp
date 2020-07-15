//
//  Track.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "Track.h"

@implementation Track

- (id)initWith:(NSString *)title duration:(int)duration andTrackUrl:(NSString *)trackUrl
{
    self = [super init];
    
    if(self)
    {
        self.title = title;
        self.duration = duration;
        self.trackUrl = trackUrl;
    }
    
    return self;
}
@end
