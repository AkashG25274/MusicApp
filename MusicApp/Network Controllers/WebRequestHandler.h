//
//  WebRequestHandler.h
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebRequestHandler : NSObject

@property (copy, nonatomic) NSString *sourceUrl;
@property (strong, nonatomic) NSMutableArray *tracks;

- (void)getTracks:(void(^)(NSArray *))completionBlock;

@end

NS_ASSUME_NONNULL_END
