//
//  HNCTopViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCTopViewController.h"
#import "Pods/UICKeyChainStore/Lib/UICKeyChainStore.h"

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
    // Do any additional setup after loading the view from its nib.
    NSLog(@"greeting: %@", [UICKeyChainStore stringForKey:@"greeting"]);
    [UICKeyChainStore setString:@"hi" forKey:@"greeting"];
    NSLog(@"greeting: %@", [UICKeyChainStore stringForKey:@"greeting"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
