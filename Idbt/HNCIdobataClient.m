//
//  HNCIdobataClient.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCIdobataClient.h"
#import "../Pods/UICKeyChainStore/Lib/UICKeyChainStore.h"

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
    [[[self defaultSession] dataTaskWithURL: url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
            if (!error) {
                completionHandler([HNCIdobataSeed idobataSeedWithData:data], response, error);
            } else {
                completionHandler(nil, response, error);
            }
        }];
    }] resume];
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

/*

 */
@end
