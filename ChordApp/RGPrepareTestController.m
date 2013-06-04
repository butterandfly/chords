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
#import "RGHelper.h"

//#include "RGConstants.h"
#import "RGConstants.h"

@interface RGPrepareTestController ()

@end

@implementation RGPrepareTestController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init the type of the quest
    NSNumber *questCate = [RGHelper objectFromUserDefaultsByKey:@"questCate"];
    if (questCate == nil) {
        questCate = [NSNumber numberWithInt:kQuestCateChordsProgression];
        [RGHelper setUserDefaultsObject:questCate byKey:kSettingQuestCategory];
    }
    [self setupQuestTypeByKey:[questCate integerValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *des = segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"BeginTest"]) {
        [des setValue:self forKey:@"delegate"];
        [des setValue:[NSNumber numberWithInteger:self.bigLevel] forKey:@"bigLevel"];
        [des setValue:[NSNumber numberWithInteger:self.questType] forKey:@"questType"];
    }
    
    if ([[segue identifier] isEqualToString:@"SetType"]) {
        [des setValue:self forKey:@"configDelegate"];
        [des setValue:[NSNumber numberWithInteger:self.questType] forKey:@"questType"];
    }
}

#pragma mark - ibactions

// Stepper's action.
- (IBAction)levelChange:(UIStepper *)sender {
    // get the value of steper
    double value = [sender value];
    
    // set field and label
    self.bigLevel = (int)value;
    self.bigLevelLabel.text = [NSString stringWithFormat:@"%d", self.bigLevel];
}

#pragma mark - Public

- (void)refreshTypeLabelByKey:(NSInteger)typeKey {
    NSDictionary *dataDict = [RGHelper plistDictByFileName:@"chords_data"];
    NSMutableArray *categoryArray = [RGHelper localizedArrayFromKeysArray:[dataDict objectForKey:@"questCategorys"]];
    self.typeLabel.text = [categoryArray objectAtIndex:typeKey];
}

- (void)setupQuestTypeByKey:(NSInteger)typeKey {
    self.questType = typeKey;
    [self refreshTypeLabelByKey:typeKey];
}

@end
