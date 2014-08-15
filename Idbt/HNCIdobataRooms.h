//
//  HNCIdobataRooms.h
//  Idbt
//
//  Created by Seiei Higa on 2014/08/16.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNCIdobataRooms : NSObject

@property (nonatomic, strong) NSArray *rooms;

- (HNCIdobataRooms *)initWithRooms:(NSArray *)rooms;

@end
