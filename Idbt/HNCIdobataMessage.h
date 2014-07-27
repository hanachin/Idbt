//
//  HNCIdobataMessage.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNCIdobataMessage : NSObject

@property (nonatomic, strong) NSDictionary *message;

@property (nonatomic) NSInteger messageId;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, strong) NSArray *mentions;
// TODO: returnDatetime
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic) NSInteger roomId;
// TODO: wrap it to sender class
@property (nonatomic, strong) NSString *senderType;
@property (nonatomic) NSInteger senderId;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSURL *senderIconUrl;

@property (nonatomic, strong) NSAttributedString *attributedString;

+ (HNCIdobataMessage *)idobataMessageWithDictionary:(NSDictionary *)data;

- (HNCIdobataMessage *)initWithDictionary:(NSDictionary *)data;

@end
