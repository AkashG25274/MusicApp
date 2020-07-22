//
//  AlbumHeaderView.m
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AlbumHeaderView.h"
#import "Constants.h"

@implementation AlbumHeaderView

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self.seeArtistButton addTarget:self action:@selector(displayArtist:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.seeArtistButton];
    }
    
    return self;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{imageView:self.imageView, titleLabel:self.textLabel, artistNameLabel:self.artistNameLabel, seeArtistButton:self.seeArtistButton};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageView(150)]-10-[titleLabel]-10-[artistNameLabel]-10-[seeArtistButton]-30-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(150)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[artistNameLabel]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[seeArtistButton]|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)displayArtist:(UIButton *)button
{
    if([self.delegate respondsToSelector:@selector(displayArtist)])
    {
        [self.delegate displayArtist];
    }
}

@end
