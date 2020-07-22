//
//  GenericHeaderView.m
//  MusicApp
//
//  Created by mmt on 21/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "GenericHeaderView.h"
#import "Constants.h"

@implementation GenericHeaderView

- (id)init
{
    self = [super init];
    
    if(self)
    {
        self.imageView = [[UIImageView alloc] init];
        [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc] init];
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        [self.textLabel setTextColor:UIColor.blackColor];
        [self addSubview:self.textLabel];
        
        self.artistNameLabel = [[UILabel alloc] init];
        [self.artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.artistNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.artistNameLabel];
        
        self.seeArtistButton = [[UIButton alloc] init];
        [self.seeArtistButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.seeArtistButton setTitle:seeArtist forState:UIControlStateNormal];
        [self.seeArtistButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.seeArtistButton addTarget:self action:@selector(displayArtist:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.seeArtistButton];
    }
    
    return self;
}

@end
