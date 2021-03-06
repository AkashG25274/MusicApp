//
//  ArtistDetailsTabBarController.h
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArtistDetailsTabBarController : UITabBarController

@property (copy, nonatomic) NSString *trackURL;

- (id)initWith:(NSString *)trackUrl;

@end

NS_ASSUME_NONNULL_END
