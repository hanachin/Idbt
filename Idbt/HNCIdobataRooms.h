//
//  HNCIdobataRooms.h
//  Idbt
//
//  Created by Seiei Higa on 2014/08/16.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNCIdobataRooms : NSObject

@property (nonatomic, strong) NSArray *all;

- (HNCIdobataRooms *)initWithRooms:(NSArray *)rooms;

- (HNCIdobataRooms *)unreadRooms;
- (HNCIdobataRooms *)organizationRooms:(NSUInteger)organizationId;
- (NSArray *)organizationIds;

@end
