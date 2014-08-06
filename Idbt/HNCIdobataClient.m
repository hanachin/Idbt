//
//  HNCIdobataClient.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataClient.h"
#import "../Pods/UICKeyChainStore/Lib/UICKeyChainStore.h"
#import "../Pods/Underscore.m/Underscore/Underscore.h"
#import "../Pods/Underscore.m/Underscore/Underscore+Functional.h"

@implementation HNCIdobataClient
{
    NSString *_email;
    NSString *_password;
}

+ (HNCIdobataClient *)defaultClient
{
    NSString *email = [UICKeyChainStore stringForKey:@"email"];
    NSString *password = [UICKeyChainStore stringForKey:@"password"];
    return [[HNCIdobataClient alloc] initWithEmail:email password: password];
}

- (HNCIdobataClient *)initWithEmail:(NSString *)email password:(NSString *)password
{
    self = [super init];
    if (self) {
        _email = email;
        _password = password;
    }
    return self;
}

- (void)seed:(void (^)(HNCIdobataSeed *seed, NSURLResponse *response, NSError *error))completionHandler;
{
    NSURL *url = [NSURL URLWithString: @"https://idobata.io/api/seed"];
    [self request:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
            if (!error) {
                completionHandler([HNCIdobataSeed idobataSeedWithData:data], response, error);
            } else {
                completionHandler(nil, response, error);
            }
        }];
    }];
}
- (void)roomMessages:(NSInteger)roomId completeHandler:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:@"%@?room_id=%ld", @"https://idobata.io/api/messages", roomId];
    NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString: urlString];
    [self messages:url completeHandler:completionHandler];
}
    
- (void)messages:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler
{
    NSURL *url = [NSURL URLWithString: @"https://idobata.io/api/messages"];
    [self messages:url completeHandler:completionHandler];
}

- (void)messages:(NSURL *)url completeHandler:(void (^)(NSArray *messages, NSURLResponse *response, NSError *error))completionHandler
{
    [self request:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
            if (!error) {
                NSArray *messages = Underscore.array([NSJSONSerialization JSONObjectWithData: data options:0 error:nil][@"messages"])
                .map(^HNCIdobataMessage *(NSDictionary *dict) {
                    return [HNCIdobataMessage idobataMessageWithDictionary: dict];
                }).sort(^(HNCIdobataMessage *a, HNCIdobataMessage *b) {
                    return [b.createdAt compare: a.createdAt];
                }).unwrap;
                completionHandler(messages, response, error);
            } else {
                NSLog(@"%@", error);
                completionHandler(nil, response, error);
            }
        }];
    }];
}


- (void)post:(NSString *)body toRoom:(NSUInteger)room_id completeHandler:(void (^)(NSDictionary *dictionary, NSURLResponse *response, NSError *error))completeHandler
{
    NSURL *url = [NSURL URLWithString:@"https://idobata.io/api/messages"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *params = @{@"room_id": [NSNumber numberWithUnsignedInteger: room_id], @"source":body};
    NSLog(@"%@", params);
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    [request setHTTPBody: postData];
    [request setHTTPMethod:@"POST"];
    [[[self defaultSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data options:0 error:nil];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completeHandler(json, response, error);
        }];
    }] resume];
}

- (void)request:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    [[[self defaultSession] dataTaskWithURL: url completionHandler: completionHandler] resume];
}


- (NSString *)basicAuthCredential
{
    NSString *basic = [NSString stringWithFormat:@"%@:%@", _email, _password];
    NSData *data = [basic dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encoded = [data base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
    return encoded;
}

- (NSString *)basicAuthAuthorizationHeader
{
    return [NSString stringWithFormat:@"Basic %@", [self basicAuthCredential]];
}

- (NSURLSessionConfiguration *)defaultConfiguration
{
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfiguration.HTTPAdditionalHeaders = @{ @"Authorization": [self basicAuthAuthorizationHeader] };
    return defaultConfiguration;
}

- (NSURLSession *)defaultSession
{
    return [NSURLSession sessionWithConfiguration: [self defaultConfiguration]];
}

@end
