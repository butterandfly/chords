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
    NSInteger normalScore =  [self.score integerValue] * 10;
    self.scoreMessage.text = [NSString stringWithFormat:@"你的得分是：%d", normalScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finish:(id)sender {
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}
@end
