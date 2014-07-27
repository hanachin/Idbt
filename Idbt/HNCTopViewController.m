//
//  HNCTopViewController.m
//  Idbt
//
//  Created by Seiei Higa on 2014/07/26.
//  Copyright (c) 2014年 Seiei Higa. All rights reserved.
//

#import "HNCTopViewController.h"
#import "HNCIdobataClient.h"
#import "../Pods/Underscore.m/Underscore/Underscore+Functional.h"

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
            NSArray *bodies = Underscore.array(messages).map(^NSString *(HNCIdobataMessage *message) { return message.body; }).unwrap;
            NSString *htmlString = [bodies componentsJoinedByString:@"\n"];
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            self.textView.attributedText = attributedString;
        }
    }];
    /*
    [[HNCIdobataClient defaultClient] seed: ^(HNCIdobataSeed *seed, NSURLResponse *response, NSError *error) {
        NSLog(@"Got response %@ with error %@.\n", response, error);
        NSLog(@"DATA:\n%@\nEND DATA\n", seed.json);
        self.textView.text = seed.json;
    }];
     */
    self.textView.text = @"hi";
}

@end
