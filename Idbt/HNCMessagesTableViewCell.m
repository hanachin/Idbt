//
//  HNCMessagesTableViewCell.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCMessagesTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
    self.username.text = message.senderName;
    self.message.attributedText = message.attributedString;
    [self.icon sd_setImageWithURL: message.senderIconUrl];
}

@end
