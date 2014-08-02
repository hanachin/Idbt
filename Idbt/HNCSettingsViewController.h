//
//  HNCSettingsViewController.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNCSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
