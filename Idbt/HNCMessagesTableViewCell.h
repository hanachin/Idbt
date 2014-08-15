//
//  HNCMessagesTableViewCell.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNCIdobataMessage.h"

@interface HNCMessagesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *datetime;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

+ (CGFloat)rowHeight;
- (void)setupWithMessage:(HNCIdobataMessage *)message;

@end
