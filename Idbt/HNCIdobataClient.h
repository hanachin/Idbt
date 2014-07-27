//
//  HNCIdobataClient.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNCIdobataSeed.h"
#import "HNCIdobataMessage.h"

@interface HNCIdobataClient : NSObject

+ (HNCIdobataClient *)defaultClient;
- (HNCIdobataClient *)initWithEmail:(NSString *)email password:(NSString *)password;
- (void)seed:(void (^)(HNCIdobataSeed *seed, NSURLResponse *response, NSError *error))completionHandler;
- (void)messages:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler;

@end
