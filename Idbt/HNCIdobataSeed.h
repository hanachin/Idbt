//
//  HNCIdobataSeed.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNCIdobataSeed : NSObject

@property (nonatomic, strong) NSDictionary *seed;
@property (nonatomic, strong) NSString *json;

+ (HNCIdobataSeed *)idobataSeedWithData:(NSData *)data;

- (HNCIdobataSeed *)initWithData:(NSData *)data;
- (NSArray *)organizations;
- (NSDictionary *)user;
- (NSArray *)rooms;
- (NSInteger)version;

@end
