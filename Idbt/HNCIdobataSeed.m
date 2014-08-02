//
//  HNCIdobataSeed.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataSeed.h"
#import "HNCIdobataRoom.h"

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
    return Underscore.array(self.seed[@"records"][@"rooms"])
    .map(^HNCIdobataRoom *(NSDictionary *room) {
        return [[HNCIdobataRoom alloc] initWithDictionary: room];
    }).unwrap;
}

- (NSDictionary *)user
{
    return self.seed[@"records"][@"user"];
}

- (NSInteger)version
{
    return [self.seed[@"version"] integerValue];
}

@end
