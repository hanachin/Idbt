//
//  HNCRoomTableViewCell.m
//  Idbt
//
//  Created by Seiei Higa on 2014/08/02.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCRoomsTableViewCell.h"
#import "HNCRoomsTableViewConstant.h"
#import "../Pods/FontAwesomeKit//FontAwesomeKit/FontAwesomeKit.h"

@implementation HNCRoomsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    FAKFontAwesome *icon = [FAKFontAwesome chevronRightIconWithSize:16];
    [self.goButton setAttributedTitle:icon.attributedString forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithRoom:(HNCIdobataRoom *)room
{
    self.room = room;
    self.roomName.text = room.name;
}

- (IBAction)go:(id)sender
{
    NSLog(@"%@", sender);
}

@end
