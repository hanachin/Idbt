//
//  HNCTimelineTableViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/08/17.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCTimelineTableViewController.h"
#import "HNCIdobataClient.h"
#import "HNCMessagesTableViewCell.h"
#import "HNCMessagesTableViewConstant.h"
#import "../Pods/FontAwesomeKit/FontAwesomeKit/FontAwesomeKit.h"

@interface HNCTimelineTableViewController ()

@end

@implementation HNCTimelineTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    FAKFontAwesome *checkIcon = [FAKFontAwesome checkIconWithSize:28.0];
    [self.markAsReadButton setImage:[checkIcon imageWithSize: CGSizeMake(28.0, 28.0)]];
    self.messages = @[];
    [[HNCIdobataClient defaultClient] messages:^(NSArray *messages, NSURLResponse *response, NSError *error) {
        self.messages = messages;
        [self.tableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.messages.count == 0) {
        return 0;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNCMessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HNCMessagesTableViewCellIdentifier forIndexPath:indexPath];
    [cell setupWithMessage: self.messages[indexPath.row]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)markAsRead:(id)sender {
}

// FIXME: copy from MessagesTableView XD
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int headingSpace = 52;
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
    int rowHeight = 44;
    return MAX(bodySize.height + topSpace + padding, rowHeight);
}
@end
