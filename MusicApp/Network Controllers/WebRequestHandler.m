//
//  WebRequestHandler.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "WebRequestHandler.h"
#import "Track.h"
#import "Album.h"
#import "Artist.h"
#import "Playlist.h"
#import "Constants.h"

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
        self.imageCache = [[NSCache alloc]init];
    }
    
    return self;
}

- (void)getTracksFrom:(NSString *)sourceUrl andCompletionHandler:(void (^)(NSArray * _Nullable))completionBlock
{
    NSURL *url = [NSURL URLWithString:sourceUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *trackList = [[NSMutableArray alloc] init];
        NSArray *trackDetails = [[NSArray alloc] init];
        
        if(jsonData)
        {
            NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
            if([sourceUrl isEqualToString:baseUrl])
            {
                NSDictionary *trackDictionary = [mainJsonDictionary objectForKey:tracks];
                trackDetails = [trackDictionary objectForKey:data];
            }
            else
            {
                trackDetails = [mainJsonDictionary objectForKey:data];
            }
            
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
                newTrack.type = [track objectForKey:type];
            
                NSDictionary *artistDetails = [track objectForKey:artist];
                Artist *artistOfCurrentTrack = [[Artist alloc] init];
                artistOfCurrentTrack = [self parseArtistDetails:artistDetails];
                newTrack.artist = artistOfCurrentTrack;
            
                NSDictionary *albumDetails = [track objectForKey:album];
                Album *albumOfCurrentTrack = [[Album alloc] init];
                albumOfCurrentTrack = [self parseAlbumDetails:albumDetails];
                newTrack.album = albumOfCurrentTrack;
            
                [trackList addObject:newTrack];
            }
        
            completionBlock(trackList);
        }
        else
        {
            completionBlock(nil);
        }
    }];
    
    [downloadTask resume];
}

- (void)getAlbums:(void (^) (NSArray * _Nullable))completionBlock
{
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(jsonData)
        {
            NSMutableArray *albumList = [[NSMutableArray alloc] init];
            NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            NSDictionary *albumDictionary = [mainJsonDictionary objectForKey:albums];
            NSArray *albumDetails = [albumDictionary objectForKey:data];
            
            for(NSDictionary *album in albumDetails)
            {
                Album *newAlbum = [[Album alloc] init];
                newAlbum = [self parseAlbumDetails:album];
            
                NSDictionary *artistDetails = [album objectForKey:artist];
                Artist *artistOfCurrentAlbum = [[Artist alloc] init];
                artistOfCurrentAlbum = [self parseArtistDetails:artistDetails];
                newAlbum.artist = artistOfCurrentAlbum;
            
                [albumList addObject:newAlbum];
            }
        
            completionBlock(albumList);
        }
        else
        {
            completionBlock(nil);
        }
    }];
    
    [downloadTask resume];
}

- (void)getArtists:(void (^) (NSArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableArray *artistList = [[NSMutableArray alloc] init];
        
        NSDictionary *mainJsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSDictionary *artistDictionary = [mainJsonDictionary objectForKey:artists];
        NSArray *artistDetails = [artistDictionary objectForKey:data];
        
        for(NSDictionary *artist in artistDetails)
        {
            Artist *newArtist = [[Artist alloc] init];
            newArtist = [self parseArtistDetails:artist];
            [artistList addObject:newArtist];
        }
        
        completionBlock(artistList);
        
    }];
    
    [downloadTask resume];
}

- (void)getPlaylists:(void (^) (NSArray *))completionBlock
{
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable jsonData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableArray *listOfPlaylists = [[NSMutableArray alloc] init];
        
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
            
            [listOfPlaylists addObject:newPlaylist];
        }
        
        completionBlock(listOfPlaylists);
        
    }];
    
    [downloadTask resume];
}

- (Artist *)parseArtistDetails:(NSDictionary *)artist
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
    
    return newArtist;
}

- (Album *)parseAlbumDetails:(NSDictionary *)album
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
    
    return newAlbum;
}

- (void)downloadImageFrom:(NSString *)imageUrl completionBlock:(void (^)(UIImage * _Nonnull))completionBlock
{
    UIImage *image = [self.imageCache objectForKey:imageUrl];
    
    if(image)
    {
        completionBlock(image);
    }
    else
    {
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSURLSessionDataTask *imageDownloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
            UIImage *image = [UIImage imageWithData:data];
            [self.imageCache setObject:image forKey:imageUrl];
            
            completionBlock(image);
        }];
        
         [imageDownloadTask resume];
    }
}

- (void)downloadPlaybackfrom:(NSString *)playbackUrl completionBlock:(void (^)(NSData * _Nullable))completionBlock
{
    NSURL *url = [NSURL URLWithString:playbackUrl];
    NSURLSessionDataTask *imageDownloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if( data )
        {
            completionBlock(data);
        }
        else
        {
            completionBlock(nil);
        }
    }];
    
    [imageDownloadTask resume];
}
@end
