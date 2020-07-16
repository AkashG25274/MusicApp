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
            newTrack.title = [track objectForKey:title];
            newTrack.duration = [[track valueForKey:duration] intValue];
            newTrack.trackUrl = [track objectForKey:preview];
            
            [self.tracks addObject:newTrack];
        }
        
        completionBlock(self.tracks);
        
    }];
    
    [downloadTask resume];
}

@end
