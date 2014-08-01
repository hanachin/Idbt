//
//  HNCTopViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCTopViewController.h"
#import "HNCIdobataClient.h"
#import "HNCMessagesTableViewController.h"

@interface HNCTopViewController ()

@end

@implementation HNCTopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToTop:(UIStoryboardSegue *)segue
{
    // do nothing
}

- (IBAction)hi:(id)sender
{
    [[HNCIdobataClient defaultClient] messages:^(NSArray *messages, NSURLResponse *response, NSError *error) {
        if (messages) {
            for (id c in self.childViewControllers) {
                if ([c isKindOfClass:[HNCMessagesTableViewController class]]) {
                    HNCMessagesTableViewController *controller = (HNCMessagesTableViewController *)c;
                    [controller.messages addObjectsFromArray: messages];
                    [controller.tableView reloadData];
                }
            }
        }
    }];
}

@end
