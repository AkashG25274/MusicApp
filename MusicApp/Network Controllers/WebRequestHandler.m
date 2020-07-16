//
//  WebRequestHandler.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "WebRequestHandler.h"
#import "../Model Classes/Track.h"
#import "../Constants.h"

@implementation WebRequestHandler

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.sourceUrl = sourceUrl;
        self.tracks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)getTracks:(void (^) (NSArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:self.sourceUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSDictionary *trackDictionary = [mainJsonDictionary objectForKey:track];
        NSArray *trackDetails = [trackDictionary objectForKey:data];
        
        for(NSDictionary *track in trackDetails)
        {
            Track *newTrack = [[Track alloc] init];
            newTrack.trackId = [[track objectForKey:trackId] longValue];
            newTrack.title = [track objectForKey:title];
            newTrack.titleShort = [track objectForKey:titleShort];
            newTrack.titleVersion = [track objectForKey:titleVersion];
            newTrack.linkUrl = [track objectForKey:linkUrl];
            newTrack.duration = [[track valueForKey:duration] intValue];
            newTrack.rank = [[track valueForKey:rank] intValue];
            newTrack.explicitLyrics = [[track objectForKey:explicitLyrics] boolValue];
            newTrack.explicitContentLyrics = [[track objectForKey:explicitContentLyrics] intValue];;
            newTrack.explicitContentCover = [[track objectForKey:explicitContentCover] intValue];;
            newTrack.trackUrl = [track objectForKey:preview];
            newTrack.position = [[track valueForKey:position] intValue];
            newTrack.type = [track objectForKey:type];
            
            [self.tracks addObject:newTrack];
        }
        
        completionBlock(self.tracks);
        
    }];
    
    [downloadTask resume];
}

@end
