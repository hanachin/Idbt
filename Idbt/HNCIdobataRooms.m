//
//  HNCIdobataRooms.m
//  Idbt
//
//  Created by Seiei Higa on 2014/08/16.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataRooms.h"
#import "HNCIdobataRoom.h"

@implementation HNCIdobataRooms

- (HNCIdobataRooms *)initWithRooms:(NSArray *)rooms
{
    self = [super init];
    if (self) {
        self.all = Underscore.array(rooms).sort(^(HNCIdobataRoom *a, HNCIdobataRoom *b) {
            return [a.name compare: b.name];
        }).unwrap;
    }
    return self;
}

- (NSArray *)unreadRooms
{
    return Underscore.array(self.all)
    .reject(^BOOL (HNCIdobataRoom *room) {
        return room.unreadMessageIds.count == 0;
    }).unwrap;
}

- (NSArray *)organizationRooms:(NSUInteger)organizationId
{
    return Underscore.array(self.all).reject(^BOOL (HNCIdobataRoom *room) {
        return room.organizationId != organizationId;
    }).unwrap;
}

@end
