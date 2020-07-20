//
//  ArtistDetailViewController.h
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Model Classes/Artist.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtistDetailViewController : UIViewController

@property (strong, nonatomic) Artist *artist;
@property (strong, nonatomic) NSArray *trackList;
@property (strong, nonatomic) NSArray *albums;

@end

NS_ASSUME_NONNULL_END