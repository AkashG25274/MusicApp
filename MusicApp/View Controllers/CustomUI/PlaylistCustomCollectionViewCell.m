//
//  PlaylistCustomCollectionViewCell.m
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "PlaylistCustomCollectionViewCell.h"
#import "../../Constants.h"

@implementation PlaylistCustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.playlistImageView = [[UIImageView alloc] init];
        [self.playlistImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.playlistImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.playlistImageView];
        
        self.playlistTitleLabel = [[UILabel alloc] init];
        [self.playlistTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.playlistTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.contentView addSubview:self.playlistTitleLabel];
        
        NSDictionary *viewsDictionary = @{playlistImageView:self.playlistImageView, playlistTitleLabel:self.playlistTitleLabel};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[playlistImageView]-10-[playlistTitleLabel]-10-|" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playlistImageView]-10-|" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playlistTitleLabel]-10-|" options:0 metrics:nil views:viewsDictionary]];
    }
    
    return self;
}

@end
