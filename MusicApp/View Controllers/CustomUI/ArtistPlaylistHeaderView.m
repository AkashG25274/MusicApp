//
//  HeaderView.m
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ArtistPlaylistHeaderView.h"

@implementation ArtistPlaylistHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.imageView = [[UIImageView alloc] init];
        [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc] init];
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.textLabel];
    }
    
    return self;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{@"imageView":self.imageView, @"textLabel":self.textLabel};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageView(150)]-10-[textLabel]-30-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(150)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textLabel]|" options:0 metrics:nil views:viewsDictionary]];
}

@end
