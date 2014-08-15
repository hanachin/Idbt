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
        self.roomId = [dictionary[@"id"] integerValue];
        self.earlyMemberIds = dictionary[@"early_member_ids"];
        self.joined = dictionary[@"joined"];
        self.name = dictionary[@"name"];
        self.organizationId = [dictionary[@"organization_id"] integerValue];
        self.partial = dictionary[@"partial"];
        self.unreadMentionIds = dictionary[@"unread_mention_ids"];
        self.unreadMessageIds = dictionary[@"unread_message_ids"];
    }
    return self;
}
@end
