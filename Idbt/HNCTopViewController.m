//
//  HNCTopViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCTopViewController.h"
#import "HNCIdobataClient.h"

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
    [[HNCIdobataClient defaultClient] seed: ^(HNCIdobataSeed *seed, NSURLResponse *response, NSError *error) {
        NSLog(@"Got response %@ with error %@.\n", response, error);
        NSLog(@"DATA:\n%@\nEND DATA\n", seed.json);
        self.textView.text = seed.json;
    }];
    self.textView.text = @"hi";
}

@end
