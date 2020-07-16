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

@property (copy, nonatomic) NSString *sourceUrl;
@property (strong, nonatomic) NSMutableArray *tracks;
@property (strong, nonatomic) NSMutableArray *albums;

+ (id)sharedHandler;
- (void)getTracks:(void(^)(NSArray *))completionBlock;
- (void)getAlbums:(void(^)(NSArray *))completionBlock;
- (void)downloadImageFrom:(NSString *)imageUrl completionBlock:(void(^)(UIImage *))completionBlock;

@end

NS_ASSUME_NONNULL_END
