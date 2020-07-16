//
//  WebRequestHandler.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "WebRequestHandler.h"
#import "../Model Classes/Track.h"

@implementation WebRequestHandler

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.sourceUrl = @"http://api.deezer.com/editorial/0/charts";
        self.tracks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)getTracks:(void (^) (NSMutableArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:self.sourceUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSDictionary *trackDictionary = [mainJsonDictionary objectForKey:@"tracks"];
        NSArray *trackDetails = [trackDictionary objectForKey:@"data"];
        
        for(NSDictionary *track in trackDetails)
        {
            NSString *trackTitle = [track objectForKey:@"title"];
            int duration = [[track valueForKey:@"duration"] intValue];
            NSString *trackUrl = [track objectForKey:@"preview"];
            
            Track *newTrack = [[Track alloc] initWith:trackTitle duration:duration andTrackUrl:trackUrl];
            [self.tracks addObject:newTrack];
        }
        
        completionBlock(self.tracks);
        
    }];
    
    [downloadTask resume];
}

@end
