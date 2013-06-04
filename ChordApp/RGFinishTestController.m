//
//  RGFinishTestController.m
//  ChordApp
//
//  Created by Zero on 13-3-8.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGFinishTestController.h"

@interface RGFinishTestController ()

@end

@implementation RGFinishTestController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger normalScore =  [self.score integerValue] * 10;
    self.scoreMessage.text = [NSString stringWithFormat:NSLocalizedString(@"YOURSCORE", nil), normalScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)finish:(id)sender {
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}
@end
