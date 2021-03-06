//
//  HNCPostViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/08/02.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCPostViewController.h"
#import "HNCIdobataClient.h"
#import "HNCPostNavigationController.h"

@interface HNCPostViewController ()

@end

@implementation HNCPostViewController

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
    // Do any additional setup after loading the view.
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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // do nothing
    }];
}

- (IBAction)done:(id)sender {
    NSLog(@"%@, %@", @"done", self.body.text);
    NSUInteger roomId = ((HNCPostNavigationController *)self.parentViewController).roomId;
    [[HNCIdobataClient defaultClient] post:self.body.text toRoom:roomId completionHandler:^(NSDictionary *dictionary, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", dictionary);
    }];
    [self dismissViewControllerAnimated:YES completion:^{
        // do nothing
    }];
}

@end
