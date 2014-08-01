//
//  HNCIdobataRoom.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/31.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataRoom.h"

@implementation HNCIdobataRoom

+ (HNCIdobataRoom *)idobataMessageWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (HNCIdobataRoom *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.roomId = (NSInteger)dictionary[@"id"];
        self.earlyMemberIds = dictionary[@"early_member_ids"];
        self.joined = dictionary[@"joined"];
        self.name = dictionary[@"name"];
        self.organizationId = (NSInteger)dictionary[@"organization_id"];
        self.partial = dictionary[@"partial"];
        self.unreadMentionIds = dictionary[@"unread_mention_ids"];
        self.unreadMessageIds = dictionary[@"unread_messages_ids"];
    }
    return self;
}
@end
