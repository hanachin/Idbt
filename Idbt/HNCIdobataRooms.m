//
//  HNCIdobataRooms.m
//  Idbt
//
//  Created by Seiei Higa on 2014/08/16.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataRooms.h"

@implementation HNCIdobataRooms

- (HNCIdobataRooms *)initWithRooms:(NSArray *)rooms
{
    self = [super init];
    if (self) {
        self.rooms = rooms;
    }
    return self;
}

@end
