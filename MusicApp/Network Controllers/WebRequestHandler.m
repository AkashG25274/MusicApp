//
//  WebRequestHandler.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "WebRequestHandler.h"
#import "../Model Classes/Track.h"
#import "../Model Classes/Album.h"
#import "../Model Classes/Artist.h"
#import "../Model Classes/Playlist.h"
#import "../Constants.h"

@implementation WebRequestHandler

+ (id)sharedHandler
{
    static WebRequestHandler *sharedHandler = nil;
    @synchronized (self) {
        
        if(sharedHandler == nil)
        {
            sharedHandler = [[WebRequestHandler alloc]init];
        }
    }
    
    return sharedHandler;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.sourceUrl = sourceUrl;
        self.tracks = [[NSMutableArray alloc] init];
        self.albums = [[NSMutableArray alloc] init];
        self.artists = [[NSMutableArray alloc] init];
        self.playlists = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)getTracks:(void (^) (NSArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:self.sourceUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSDictionary *trackDictionary = [mainJsonDictionary objectForKey:tracks];
        NSArray *trackDetails = [trackDictionary objectForKey:data];
        
        for(NSDictionary *track in trackDetails)
        {
            Track *newTrack = [[Track alloc] init];
            newTrack.trackId = [[track objectForKey:idString] longValue];
            newTrack.title = [track objectForKey:title];
            newTrack.titleShort = [track objectForKey:titleShort];
            newTrack.titleVersion = [track objectForKey:titleVersion];
            newTrack.trackInfoUrl = [track objectForKey:linkUrl];
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

- (void)getAlbums:(void (^) (NSArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:self.sourceUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSDictionary *albumDictionary = [mainJsonDictionary objectForKey:albums];
        NSArray *albumDetails = [albumDictionary objectForKey:data];
        
        for(NSDictionary *album in albumDetails)
        {
            Album *newAlbum = [[Album alloc] init];
            newAlbum.albumId = [[album objectForKey:idString] longValue];
            newAlbum.title = [album objectForKey:title];
            newAlbum.albumInfoUrl = [album objectForKey:linkUrl];
            newAlbum.coverImageUrl = [album objectForKey:cover];
            newAlbum.coverSmallUrl = [album objectForKey:coverSmall];
            newAlbum.coverMediumUrl = [album objectForKey:coverMedium];
            newAlbum.coverBigUrl = [album objectForKey:coverBig];
            newAlbum.coverXlUrl = [album objectForKey:coverXl];
            newAlbum.recordType = [album objectForKey:recordType];
            newAlbum.trackListUrl = [album objectForKey:trackList];
            newAlbum.explicitLyrics = [[album objectForKey:explicitLyrics] boolValue];
            newAlbum.position = [[album valueForKey:position] intValue];
            newAlbum.type = [album objectForKey:type];
            
            [self.albums addObject:newAlbum];
        }
        
        completionBlock(self.albums);
        
    }];
    
    [downloadTask resume];
}

- (void)getArtists:(void (^) (NSArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:self.sourceUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSDictionary *artistDictionary = [mainJsonDictionary objectForKey:artists];
        NSArray *artistDetails = [artistDictionary objectForKey:data];
        
        for(NSDictionary *artist in artistDetails)
        {
            Artist *newArtist = [[Artist alloc] init];
            newArtist.artistId = [[artist objectForKey:idString] longValue];
            newArtist.name = [artist objectForKey:name];
            newArtist.artistInfoUrl = [artist objectForKey:linkUrl];
            newArtist.pictureUrl = [artist objectForKey:picture];
            newArtist.smallPictureUrl = [artist objectForKey:pictureSmall];
            newArtist.mediumPictureUrl = [artist objectForKey:pictureMedium];
            newArtist.bigPictureUrl = [artist objectForKey:pictureBig];
            newArtist.xlPictureUrl = [artist objectForKey:pictureXl];
            newArtist.radio = [[artist objectForKey:radio] boolValue];
            newArtist.trackListUrl = [artist objectForKey:trackList];
            newArtist.position = [[artist valueForKey:position] intValue];
            newArtist.type = [artist objectForKey:type];
            
            [self.artists addObject:newArtist];
        }
        
        completionBlock(self.artists);
        
    }];
    
    [downloadTask resume];
}

- (void)getPlaylists:(void (^) (NSArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:self.sourceUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSDictionary *playlistDictionary = [mainJsonDictionary objectForKey:playlists];
        NSArray *playlistDetails = [playlistDictionary objectForKey:data];
        
        for(NSDictionary *playlist in playlistDetails)
        {
            Playlist *newPlaylist = [[Playlist alloc] init];
            newPlaylist.playlistId = [[playlist objectForKey:idString] longValue];
            newPlaylist.title = [playlist objectForKey:title];
            newPlaylist.publicPlaylist = [[playlist objectForKey:publicString] boolValue];
            newPlaylist.totalTracks = [[playlist valueForKey:nbTracks] intValue];
            newPlaylist.playlistInfoUrl = [playlist objectForKey:linkUrl];
            newPlaylist.pictureUrl = [playlist objectForKey:picture];
            newPlaylist.smallPictureUrl = [playlist objectForKey:pictureSmall];
            newPlaylist.mediumPictureUrl = [playlist objectForKey:pictureMedium];
            newPlaylist.bigPictureUrl = [playlist objectForKey:pictureBig];
            newPlaylist.xlPictureUrl = [playlist objectForKey:pictureXl];
            newPlaylist.checksum = [playlist objectForKey:checksum];
            newPlaylist.trackListUrl = [playlist objectForKey:trackList];
            newPlaylist.creationDate = [playlist objectForKey:creationDate];
            newPlaylist.type = [playlist objectForKey:type];
            
            [self.playlists addObject:newPlaylist];
        }
        
        completionBlock(self.playlists);
        
    }];
    
    [downloadTask resume];
}

- (void)downloadImageFrom:(NSString *)imageUrl completionBlock:(void (^)(UIImage * _Nonnull))completionBlock
{
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLSessionDataTask *imageDownloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        UIImage *image = [UIImage imageWithData:data];
        
        completionBlock(image);
    }];
    
    [imageDownloadTask resume];
}

@end
