//
//  AlbumCustomCollectionViewCell.m
//  MusicApp
//
//  Created by mmt on 16/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AlbumCustomCollectionViewCell.h"
#import "../../Constants.h"

@implementation AlbumCustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.albumImageView = [[UIImageView alloc] init];
        [self.albumImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.albumImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.albumImageView];
        
        self.albumTitleLabel = [[UILabel alloc] init];
        [self.albumTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.albumTitleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self.contentView addSubview:self.albumTitleLabel];
        
        NSDictionary *viewsDictionary = @{albumImageView:self.albumImageView, albumTitleLabel:self.albumTitleLabel};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[albumImageView]-10-[albumTitleLabel]-10-|" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[albumImageView]-10-|" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[albumTitleLabel]-10-|" options:0 metrics:nil views:viewsDictionary]];
    }
    
    return self;
}
@end
