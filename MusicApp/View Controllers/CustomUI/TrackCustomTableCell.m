//
//  TrackCustomTableCell.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "TrackCustomTableCell.h"
#import "../../Constants.h"

@implementation TrackCustomTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        [self.contentView addSubview:self.titleLabel];
        
        self.artistNameLabel = [[UILabel alloc] init];
        [self.artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.artistNameLabel setFont:[UIFont systemFontOfSize:15.0]];
        [self.contentView addSubview:self.artistNameLabel];
        
        self.optionsButton = [[UIButton alloc] init];
        [self.optionsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.optionsButton setTitle:@"Options" forState:UIControlStateNormal];
        [self.optionsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.optionsButton addTarget:self action:@selector(optionsTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.optionsButton];
        
        NSDictionary *viewsDictionary = @{titleLabel:self.titleLabel, artistNameLabel:self.artistNameLabel, optionsButton:self.optionsButton};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]-10-[artistNameLabel]" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[optionsButton]-15-|" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[titleLabel]" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[artistNameLabel]-[optionsButton]-10-|" options:0 metrics:nil views:viewsDictionary]];
    }
    
    return self;
}

- (void)optionsTapped:(UIButton *)button
{
    if([self.delegate respondsToSelector:@selector(displayOptions)])
    {
        [self.delegate displayOptions];
    }
}

@end
