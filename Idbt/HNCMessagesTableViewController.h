//
//  HNCMessagesTableViewController.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNCMessagesTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic) NSUInteger roomId;

@end
