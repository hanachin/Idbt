//
//  HNCRoomTableViewCell.h
//  Idbt
//
//  Created by Seiei Higa on 2014/08/02.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNCIdobataRoom.h"

@interface HNCRoomsTableViewCell : UITableViewCell

@property (strong, nonatomic) HNCIdobataRoom *room;
@property (weak, nonatomic) IBOutlet UILabel *roomName;

- (void)setupWithRoom:(HNCIdobataRoom *)room;

@end
