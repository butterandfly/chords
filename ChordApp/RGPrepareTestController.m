//
//  RGPrepareTestController.m
//  ChordApp
//
//  Created by Zero on 13-3-2.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGPrepareTestController.h"

@interface RGPrepareTestController ()

@end

@implementation RGPrepareTestController

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"%@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"BeginTest"]) {
         // begin the test
//        NSLog(@"prepare the segue");
        UIViewController *des = segue.destinationViewController;
        [des setValue:self forKey:@"delegate"];
    }
}

@end
