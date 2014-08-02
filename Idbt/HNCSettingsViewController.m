//
//  HNCSettingsViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCSettingsViewController.h"
#import "../Pods/UICKeyChainStore/Lib/UICKeyChainStore.h"

@interface HNCSettingsViewController ()

@end

@implementation HNCSettingsViewController

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
    self.email.text = [UICKeyChainStore stringForKey:@"email"];
    self.password.text = [UICKeyChainStore stringForKey:@"password"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)done:(id)sender
{
    [UICKeyChainStore setString:self.email.text forKey:@"email"];
    [UICKeyChainStore setString:self.password.text forKey:@"password"];
    [self performSegueWithIdentifier:@"setting done" sender:self];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // do nothing;
    }];
}

@end
