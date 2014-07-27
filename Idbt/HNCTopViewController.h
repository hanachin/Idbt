//
//  HNCTopViewController.h
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNCTopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)unwindToTop:(UIStoryboardSegue *)segue;
- (IBAction)hi:(id)sender;

@end
