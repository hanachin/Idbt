//
//  HNCRoomTableViewCell.m
//  Idbt
//
//  Created by Seiei Higa on 2014/08/02.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCRoomsTableViewCell.h"
#import "HNCRoomsTableViewConstant.h"

@implementation HNCRoomsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithRoom:(HNCIdobataRoom *)room
{
    self.room = room;
    self.textLabel.text = room.name;
}

@end
