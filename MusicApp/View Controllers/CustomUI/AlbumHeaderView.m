//
//  AlbumHeaderView.m
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AlbumHeaderView.h"

@implementation AlbumHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.albumImageView = [[UIImageView alloc] init];
        [self.albumImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.albumImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.albumImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        
        self.artistNameLabel = [[UILabel alloc] init];
        [self.artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.artistNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.artistNameLabel];
        
        self.seeArtistButton = [[UIButton alloc] init];
        [self.seeArtistButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.seeArtistButton setTitle:@"See Artist" forState:UIControlStateNormal];
        [self.seeArtistButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.seeArtistButton addTarget:self action:@selector(displayArtist:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.seeArtistButton];
    }
    
    return self;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{@"albumImageView":self.albumImageView, @"titleLabel":self.titleLabel, @"artistNameLabel":self.artistNameLabel, @"seeArtistButton":self.seeArtistButton};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[albumImageView(150)]-10-[titleLabel]-10-[artistNameLabel]-10-[seeArtistButton]-30-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[albumImageView(150)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[artistNameLabel]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[seeArtistButton]|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)displayArtist:(UIButton *)button
{
    
}

@end
