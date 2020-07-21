//
//  TrackDetailsDelegate.h
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MusicDelegate <NSObject>

@optional
- (void)displayOptions:(UITableViewCell *)cell;
- (void)displayArtist;

@end

NS_ASSUME_NONNULL_END
