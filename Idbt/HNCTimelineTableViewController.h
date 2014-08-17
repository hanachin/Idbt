//
//  HNCTimelineTableViewController.h
//  Idbt
//
//  Created by Seiei Higa on 2014/08/17.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNCIdobataRooms.h"

@interface HNCTimelineTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *markAsReadButton;
@property (strong, nonatomic) NSArray *messages;
- (IBAction)markAsRead:(id)sender;

@end
