//
//  HNCRoomsControllerTableViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/31.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCRoomsTableViewController.h"
#import "HNCRoomsTableViewCell.h"
#import "HNCIdobataClient.h"
#import "HNCRoomsTableViewConstant.h"
#import "HNCMessagesTableViewController.h"
#import "../Pods/FontAwesomeKit/FontAwesomeKit/FontAwesomeKit.h"

@interface HNCRoomsTableViewController ()

@end

@implementation HNCRoomsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rooms = [[HNCIdobataRooms alloc] initWithRooms:@[]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    FAKFontAwesome *settingIcon = [FAKFontAwesome gearIconWithSize: 28.0];
    self.setting.image = [settingIcon imageWithSize: CGSizeMake(28.0, 28.0)];
    FAKIonIcons *chatbubbleIcon = [FAKIonIcons chatbubbleIconWithSize:24.0];
    self.filterUnread = NO;
    [self.filterSegment setImage:[chatbubbleIcon imageWithSize:CGSizeMake(24.0, 24.0)] forSegmentAtIndex:0];
    FAKIonIcons *chatbubbleWorkingIcon = [FAKIonIcons chatbubbleWorkingIconWithSize:24.0];
    [self.filterSegment setImage:[chatbubbleWorkingIcon imageWithSize:CGSizeMake(24.0, 24.0)] forSegmentAtIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.seed.organizations.count;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.seed.organizations objectAtIndex:section][@"name"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger organizationId = [[self.seed.organizations objectAtIndex:section][@"id"] integerValue];
    return [self.rooms organizationRooms:organizationId].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger organizationId = [[self.seed.organizations objectAtIndex:indexPath.section][@"id"] integerValue];
    NSArray *rooms = [self.rooms organizationRooms:organizationId];

    HNCRoomsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HNCRoomsTableViewCellIdentifier forIndexPath:indexPath];
    [cell setupWithRoom: [rooms objectAtIndex:indexPath.row]];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    // [self.navigationController pushViewController:detailViewController animated:YES];
    NSLog(@"%@ clicked", [[self.rooms objectAtIndex:indexPath.row] name]);
}
 */

- (IBAction)refreshRooms:(id)sender
{
    [[HNCIdobataClient defaultClient] seed:^(HNCIdobataSeed *seed, NSURLResponse *response, NSError *error) {
        self.seed = seed;
        self.rooms = seed.rooms;
        NSLog(@"%@", seed);
        [self.tableView reloadData];
    }];
}

- (IBAction)toggleFilter:(id)sender {
    if ([self.filterSegment selectedSegmentIndex] == 0) {
        self.filterUnread = NO;
    } else {
        self.filterUnread = YES;
    }
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@", segue.identifier);
    if ([segue.identifier isEqualToString:@"room selected"]) {
        HNCRoomsTableViewCell *cell = (HNCRoomsTableViewCell*)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        NSLog(@"%@", cell.room.name);
        HNCMessagesTableViewController *controller = (HNCMessagesTableViewController *)segue.destinationViewController;
        NSUInteger roomId = cell.room.roomId;
        controller.roomId = roomId;
        [controller setTitle: cell.room.name];
        [[HNCIdobataClient defaultClient] roomMessages: roomId completeHandler:^(NSArray *messages, NSURLResponse *response, NSError *error) {
            [controller.messages addObjectsFromArray: messages];
            [controller.tableView reloadData];
        }];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (NSArray *)filteredRooms
{
    if (!self.filterUnread) {
        return self.rooms.all;
    }
    return self.rooms.unreadRooms;
}

@end
