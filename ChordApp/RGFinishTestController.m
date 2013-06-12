//
//  RGFinishTestController.m
//  ChordApp
//
//  Created by Zero on 13-3-8.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGFinishTestController.h"

@interface RGFinishTestController ()

- (NSInteger)normalScore;

@end

@implementation RGFinishTestController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scoreMessage.text = [NSString stringWithFormat:NSLocalizedString(@"YOURSCORE", nil), [self normalScore]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)finish:(id)sender {
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)normalScore {
    return [self.score integerValue] * 10;
}

@end
