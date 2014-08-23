//
//  HNCIdobataClient.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNCIdobataSeed.h"
#import "HNCIdobataMessage.h"
#import "HNCIdobataRoom.h"

@interface HNCIdobataClient : NSObject

+ (HNCIdobataClient *)defaultClient;
- (HNCIdobataClient *)initWithEmail:(NSString *)email password:(NSString *)password;
- (BOOL)isConfigured;
- (void)seed:(void (^)(HNCIdobataSeed *seed, NSURLResponse *response, NSError *error))completionHandler;
- (void)messages:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler;
- (void)messagesBefore:(NSInteger)messageId completionHandler:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler;
- (void)messagesAfter:(NSInteger)messageId completionHandler:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler;
- (void)roomMessages:(NSInteger)roomId completionHandler:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler;
- (void)roomMessages:(NSInteger)roomId before:(NSInteger)messageId completionHandler:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler;
- (void)roomMessages:(NSInteger)roomId after:(NSInteger)messageId completionHandler:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler;
- (void)post:(NSString *)body toRoom:(NSUInteger)room_id completionHandler:(void (^)(NSDictionary *dictionary, NSURLResponse *response, NSError *error))completionHandler;
- (void)markAllAsRead:(void (^)(NSString *body, NSURLResponse *response, NSError *error))completionHandler;
- (void)markAsRead:(NSInteger)roomId completionHandler:(void (^)(NSString *body, NSURLResponse *response, NSError *error))completionHandler;

@end
