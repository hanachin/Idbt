//
//  HNCMessagesTableViewCell.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCMessagesTableViewCell.h"

@implementation HNCMessagesTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight
{
    return 44.0f;
}

- (void)setupWithMessage:(HNCIdobataMessage *)message
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[message.body dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.username.text = message.senderName;
    self.message.attributedText = attributedString;
    [self loadIconImage: message.senderIconUrl];
}

- (void)loadIconImage:(NSURL *)url
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithURL: url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData: data];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.icon.image = image;
                [self setNeedsLayout];
            }];
        }
    }];
    [task resume];
}

@end
