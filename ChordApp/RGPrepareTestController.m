//
//  RGPrepareTestController.m
//  ChordApp
//
//  Created by Zero on 13-3-2.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGPrepareTestController.h"
#import "RGTestController.h"
#import "RGTestTypeViewController.h"

#include "RGConstants.h"

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
    
    self.questType = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"%@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"BeginTest"]) {
        RGTestController *des = segue.destinationViewController;
        [des setValue:self forKey:@"delegate"];
        des.bigLevel = self.bigLevel;
        des.questType = self.questType;
    }
    
    if ([[segue identifier] isEqualToString:@"SetType"]) {
         //
        RGTestTypeViewController *des = segue.destinationViewController;
        [des setValue:self forKey:@"configDelegate"];
        des.questType = self.questType;
        
//        [des setValue:self.typeIndex forKey:@"lastIndex"];
    }
}

- (IBAction)levelChange:(UIStepper *)sender {
    double value = [sender value];
    
    self.bigLevel = (int)value;
    self.bigLevelLabel.text = [NSString stringWithFormat:@"%d", self.bigLevel];
}
@end
