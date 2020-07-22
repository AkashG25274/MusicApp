//
//  GenericHeaderView.h
//  MusicApp
//
//  Created by mmt on 21/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenericHeaderView : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *artistNameLabel;
@property (strong, nonatomic) UIButton *seeArtistButton;

@end

NS_ASSUME_NONNULL_END
