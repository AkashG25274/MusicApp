//
//  Artist.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Artist : NSObject

@property (assign) long int artistId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *artistInfoUrl;
@property (copy, nonatomic) NSString *pictureUrl;
@property (copy, nonatomic) NSString *smallPictureUrl;
@property (copy, nonatomic) NSString *mediumPictureUrl;
@property (copy, nonatomic) NSString *bigPictureUrl;
@property (copy, nonatomic) NSString *xlPictureUrl;
@property (assign) BOOL radio;
@property (strong, nonatomic) NSString *trackListUrl;
@property (assign) int position;
@property (copy, nonatomic) NSString *type;

@end

NS_ASSUME_NONNULL_END
