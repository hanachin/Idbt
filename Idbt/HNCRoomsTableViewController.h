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

@property (weak, nonatomic) IBOutlet UIBarButtonItem *setting;
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegment;
@property (nonatomic, strong) HNCIdobataSeed *seed;
@property (nonatomic, strong) HNCIdobataRooms *rooms;
@property BOOL filterUnread;


- (IBAction)refreshRooms:(id)sender;
- (IBAction)toggleFilter:(id)sender;

@end
