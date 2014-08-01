//
//  HNCIdobataRoom.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/31.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNCIdobataRoom : NSObject

@property (nonatomic) NSInteger roomId;
@property (nonatomic, strong) NSArray *earlyMemberIds;
@property (nonatomic) BOOL joined;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger organizationId;
@property (nonatomic) BOOL partial;
@property (nonatomic, strong) NSArray *unreadMentionIds;
@property (nonatomic, strong) NSArray *unreadMessageIds;

+ (HNCIdobataRoom *)idobataMessageWithDictionary:(NSDictionary *)data;

- (HNCIdobataRoom *)initWithDictionary:(NSDictionary *)data;

@end
