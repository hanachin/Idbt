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
{
    NSInteger _timeline;
}

- (void)viewDidLoad
{
    _timeline = 1;
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];

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

- (void)viewDidAppear:(BOOL)animated
{
    if ([[HNCIdobataClient defaultClient] isConfigured]) {
        [self refresh];
    } else {
        [self performSegueWithIdentifier:@"openConfig" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.filteredOrganizations.count == 0) {
        return 0;
    } else {
        return self.filteredOrganizations.count + _timeline;
    }

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section < _timeline) {
        return @"Timeline";
    } else {
        return [self.filteredOrganizations objectAtIndex:section - _timeline][@"name"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < _timeline) {
        return _timeline;
    } else {
        NSInteger organizationId = [[self.filteredOrganizations objectAtIndex:section - _timeline][@"id"] integerValue];
        return [self.filteredRooms organizationRooms:organizationId].all.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _timeline) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"HNCRoomsTableViewTimelineCell" forIndexPath:indexPath];
        NSInteger total = self.rooms.totalUnreadCount;
        if (total == 0) {
            cell.detailTextLabel.text = @"";
        } else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)total];
        }
        return cell;
    } else {
        NSInteger organizationId = [[self.filteredOrganizations objectAtIndex:indexPath.section - _timeline][@"id"] integerValue];
        NSArray *rooms = [self.filteredRooms organizationRooms:organizationId].all;

        HNCRoomsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HNCRoomsTableViewCellIdentifier forIndexPath:indexPath];
        [cell setupWithRoom: [rooms objectAtIndex:indexPath.row]];
        return cell;
    }
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
        HNCIdobataClient *client = [HNCIdobataClient defaultClient];
        [client roomMessages: roomId completionHandler:^(NSArray *messages, NSURLResponse *response, NSError *error) {
            [controller.messages addObjectsFromArray: messages];
            [controller.tableView reloadData];
            /*
             mark room as read doesn't work
            [client markAsRead:roomId completionHandler:^(NSString *body, NSURLResponse *response, NSError *error) {
                NSLog(@"%@, response: %@ error:%@", @"touched", response, error);
            }];
             */
        }];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (NSArray *)filteredOrganizations
{
    NSArray *rooms = self.filteredRooms.organizationIds;
    return Underscore.array(rooms).map(^NSDictionary *(NSNumber *organizationId) {
        return Underscore.array(self.seed.organizations).find(^BOOL (NSDictionary *organization) {
            return [organization[@"id"] unsignedIntegerValue] == [organizationId unsignedIntegerValue];
        });
    }).sort(^(NSDictionary *a, NSDictionary *b) {
        return [a[@"name"] compare: b[@"name"]];
    }).unwrap;
}

- (HNCIdobataRooms *)filteredRooms
{
    if (!self.filterUnread) {
        return self.rooms;
    }
    return self.rooms.unreadRooms;
}

- (void)refresh
{
    [[HNCIdobataClient defaultClient] seed:^(HNCIdobataSeed *seed, NSURLResponse *response, NSError *error) {
        self.seed = seed;
        self.rooms = seed.rooms;
        NSLog(@"%@", seed);
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)unwindToRoomsView:(UIStoryboardSegue *)segue
{
    if ([[HNCIdobataClient defaultClient] isConfigured]) {
        [self refresh];
    }
}

@end
