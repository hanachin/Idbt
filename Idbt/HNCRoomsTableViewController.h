//
//  HNCRoomsControllerTableViewController.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/31.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNCIdobataSeed.h"

@interface HNCRoomsTableViewController : UITableViewController

@property (nonatomic, strong) HNCIdobataSeed *seed;
@property (nonatomic, strong) NSArray *rooms;

- (IBAction)refreshRooms:(id)sender;

@end
