//
//  HNCMessagesTableViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/27.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCMessagesTableViewController.h"
#import "HNCMessagesTableViewConstant.h"
#import "HNCMessagesTableViewCell.h"
#import "HNCIdobataClient.h"
#import "HNCIdobataMessage.h"
#import "HNCPostNavigationController.h"

@interface HNCMessagesTableViewController ()

@end

@implementation HNCMessagesTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(updateMessages) forControlEvents:UIControlEventValueChanged];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.messages =[NSMutableArray array];
    self.loadingOldMessages = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNCMessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HNCMessagesTableViewCellIdentifier forIndexPath:indexPath];
    HNCIdobataMessage *message = [self.messages objectAtIndex:indexPath.row];
    [cell setupWithMessage:message];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"post to room"]) {
        HNCPostNavigationController *controller = (HNCPostNavigationController *)segue.destinationViewController;
        controller.roomId = self.roomId;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int headingSpace = 57;
    int trailingSpace = 10;
    int textWidth = self.tableView.frame.size.width - headingSpace - trailingSpace;

    HNCIdobataMessage *message = self.messages[indexPath.row];
    CGSize boundingRect = CGSizeMake(textWidth, CGFLOAT_MAX);

    CGSize bodySize = [message.attributedString boundingRectWithSize: boundingRect
                                                 options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                 context: nil
                          ].size;
    int topSpace = 20;
    int padding = 10;
    int rowHeight = 44 + 10; // 5px around icon
    return MAX(bodySize.height + topSpace + padding, rowHeight);
}


- (HNCIdobataMessage *)oldestMessage
{
    return self.messages.lastObject;
}

- (HNCIdobataMessage *)latestMessage
{
    return self.messages.firstObject;
}

- (void)updateMessages
{
    NSLog(@"latest: %@", [self latestMessage].body);
    [[HNCIdobataClient defaultClient] roomMessages:self.roomId after:[self latestMessage].messageId completionHandler:^(NSArray *messages, NSURLResponse *response, NSError *error) {
        NSMutableArray *newMessages = [[NSMutableArray alloc] initWithArray:messages];
        [newMessages addObjectsFromArray: self.messages];
        self.messages = newMessages;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[super tableView: tableView willDisplayCell: cell forRowAtIndexPath: indexPath];
    if (indexPath.row == (self.messages.count - 1) && !self.loadingOldMessages) {
        [self loadOldMessages];
    }
}

- (void)loadOldMessages
{
    self.loadingOldMessages = YES;
    [[HNCIdobataClient defaultClient] roomMessages:self.roomId before:[self oldestMessage].messageId completionHandler:^(NSArray *messages, NSURLResponse *response, NSError *error) {
        NSMutableArray *newMessages = [[NSMutableArray alloc] initWithArray: self.messages];
        [newMessages addObjectsFromArray: messages];
        self.messages = newMessages;
        [self.tableView reloadData];
        self.loadingOldMessages = NO;
    }];
}


@end
