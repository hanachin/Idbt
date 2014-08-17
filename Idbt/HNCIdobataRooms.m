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

- (HNCIdobataRooms *)unreadRooms
{
    NSArray *rooms = Underscore.array(self.all)
    .reject(^BOOL (HNCIdobataRoom *room) {
        return room.unreadMessageIds.count == 0;
    }).unwrap;
    return [[HNCIdobataRooms alloc] initWithRooms:rooms];
}

- (HNCIdobataRooms *)organizationRooms:(NSUInteger)organizationId
{
    NSArray *rooms = Underscore.array(self.all).reject(^BOOL (HNCIdobataRoom *room) {
        return room.organizationId != organizationId;
    }).unwrap;
    return [[HNCIdobataRooms alloc] initWithRooms:rooms];
}

- (NSArray *)organizationIds
{
    return Underscore.array(self.all).map(^NSNumber *(HNCIdobataRoom *room) {
        return [NSNumber numberWithUnsignedInteger: room.organizationId];
    }).uniq.unwrap;
}


- (NSInteger)totalUnreadCount
{
    NSNumber *total = Underscore.array(self.all).reduce(@0, ^(NSNumber *total, HNCIdobataRoom *room) {
        return [NSNumber numberWithInteger: total.integerValue + room.unreadMessageIds.count];
    });
    return total.integerValue;
}
@end
