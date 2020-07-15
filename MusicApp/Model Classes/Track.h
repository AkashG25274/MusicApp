//
//  Track.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Track : NSObject

@property (copy, nonatomic) NSString *title;
@property (assign) int duration;
@property (copy, nonatomic) NSString *trackUrl;

- (id)initWith:(NSString *)title duration:(int)duration andTrackUrl:(NSString *)trackUrl;

@end

NS_ASSUME_NONNULL_END
