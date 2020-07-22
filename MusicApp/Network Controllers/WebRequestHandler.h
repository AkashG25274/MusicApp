//
//  WebRequestHandler.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebRequestHandler : NSObject

@property (strong, nonatomic) NSCache *imageCache;

+ (id)sharedHandler;
- (void)getTracksFrom:(NSString *)sourceUrl andCompletionHandler:(void(^)(NSArray *))completionBlock;
- (void)getAlbums:(void(^)(NSArray *))completionBlock;
- (void)getArtists:(void(^)(NSArray *))completionBlock;
- (void)getPlaylists:(void(^)(NSArray *))completionBlock;
- (void)downloadImageFrom:(NSString *)imageUrl completionBlock:(void(^)(UIImage *))completionBlock;
- (void)downloadPlaybackfrom:(NSString *)url completionBlock:(void(^)(NSData *))completionBlock;

@end

NS_ASSUME_NONNULL_END
