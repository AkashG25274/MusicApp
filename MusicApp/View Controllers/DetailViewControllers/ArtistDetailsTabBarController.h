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

@property (strong, nonatomic) NSString *trackURL;
@property (strong, nonatomic) NSString *albumURL;

@end

NS_ASSUME_NONNULL_END
