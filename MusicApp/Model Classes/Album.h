//
//  Album.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"

NS_ASSUME_NONNULL_BEGIN

@interface Album : NSObject

@property (assign) long int albumId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *albumInfoUrl;
@property (copy, nonatomic) NSString *coverImageUrl;
@property (copy, nonatomic) NSString *coverSmallUrl;
@property (copy, nonatomic) NSString *coverMediumUrl;
@property (copy, nonatomic) NSString *coverBigUrl;
@property (copy, nonatomic) NSString *coverXlUrl;
@property (copy, nonatomic) NSString *recordType;
@property (strong, nonatomic) NSString *trackListUrl;
@property (assign) BOOL explicitLyrics;
@property (assign) int position;
@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic) Artist *artist;

@end

NS_ASSUME_NONNULL_END
