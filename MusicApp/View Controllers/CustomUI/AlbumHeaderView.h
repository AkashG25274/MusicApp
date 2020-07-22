//
//  AlbumHeaderView.h
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDelegate.h"
#import "GenericHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlbumHeaderView : GenericHeaderView//UIView

//@property (strong, nonatomic) UIImageView *albumImageView;
//@property (strong, nonatomic) UILabel *titleLabel;
//@property (strong, nonatomic) UILabel *artistNameLabel;
//@property (strong, nonatomic) UIButton *seeArtistButton;
@property (strong, nonatomic) id <MusicDelegate> delegate;

- (void)setUpConstraints;

@end

NS_ASSUME_NONNULL_END
