//
//  HNCIdobataMessage.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataMessage.h"

@implementation HNCIdobataMessage

+ (HNCIdobataMessage *)idobataMessageWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (HNCIdobataMessage *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.message = dictionary;
        self.messageId = (NSInteger)self.message[@"id"];
        self.body = self.message[@"body"];
        self.imageUrls = self.message[@"image_urls"];
        self.mentions = self.message[@"mentions"];
        self.createdAt = self.message[@"created_at"];
        self.roomId = (NSInteger)self.message[@"room_id"];
        self.senderType = self.message[@"sender_type"];
        self.senderId = (NSInteger)self.message[@"sender_id"];
        self.senderName = self.message[@"sender_name"];
        self.senderIconUrl = [NSURL URLWithString: self.message[@"sender_icon_url"]];
    }
    return self;
}

@end
