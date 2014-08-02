//
//  HNCPostViewController.h
//  Idbt
//
//  Created by Seiei Higa on 2014/08/02.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNCPostViewController : UIViewController
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *body;

@end
