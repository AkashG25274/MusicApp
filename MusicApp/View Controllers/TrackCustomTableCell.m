//
//  TrackCustomTableCell.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "TrackCustomTableCell.h"

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
        
        NSDictionary *viewsDictionary = @{@"titleLabel":self.titleLabel, @"artistNameLabel":self.artistNameLabel};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]-10-[artistNameLabel]" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[titleLabel]" options:0 metrics:nil views:viewsDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[artistNameLabel]" options:0 metrics:nil views:viewsDictionary]];
    }
    
    return self;
}

@end
