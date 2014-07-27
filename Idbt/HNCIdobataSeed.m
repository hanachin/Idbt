//
//  HNCIdobataSeed.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataSeed.h"

@implementation HNCIdobataSeed

+ (HNCIdobataSeed *)idobataSeedWithData:(NSData *)data
{
    return [[self alloc] initWithData:data];
}

- (HNCIdobataSeed *)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.json = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        self.seed = [NSJSONSerialization JSONObjectWithData: data options:0 error:nil];
    }
    return self;
}

- (NSArray *)organizations
{
    return self.seed[@"records"][@"organizations"];
}

- (NSArray *)rooms
{
    return self.seed[@"records"][@"rooms"];
}

- (NSDictionary *)user
{
    return self.seed[@"records"][@"user"];
}

- (NSInteger)version
{
    return (NSInteger)self.seed[@"version"];
}

@end
