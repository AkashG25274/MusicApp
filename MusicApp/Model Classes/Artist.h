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

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *imageUrl;

- (id)initWith:(NSString *)name andImageUrl:(NSString *)imageUrl;

@end

NS_ASSUME_NONNULL_END
