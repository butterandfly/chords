//
//  RGChordsController.m
//  ChordApp
//
//  Created by Zero on 13-4-12.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGChordsController.h"
#import "NSArray+SortBy.h"
#import "RGChordsMediator.h"
#import "RGPlayerController.h"
#import "RGHelper.h"

#import "RGConstants.h"

@interface RGChordsController () {
    RGChordsMediator *_chordsMediator;
    RGPlayerController *_playerController;
}

- (void)setupButtonsTextWithChordsArray:(NSArray*)chordsArray;

@end

@implementation RGChordsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chordsMediator = [RGChordsMediator sharedChordsMediator];
    _chordsMediator.chordsController = self;
    
    self.isEditing = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *chordsArray = [RGHelper objectFromUserDefaultsByKey:kSettingChordsArray];
    if (chordsArray == nil) {
        // Default array.
        chordsArray = @[@"C", @"F", @"G", @"Am", @"Em", @"Dm", @"G7", @"D", @"E"];
        [RGHelper setUserDefaultsObject:chordsArray byKey:kSettingChordsArray];
    }
    
    [self setupButtonsTextWithChordsArray:chordsArray];
    
    _playerController = [RGPlayerController sharedPlayerController];
    [_playerController setupButtonChords];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueId = segue.identifier;
    UIViewController *des = segue.destinationViewController;
    
    if ([segueId isEqualToString:@"ChordSetting"]) {
        UIButton *button = (UIButton*)sender;
        NSNumber *buttonTag = [NSNumber numberWithInteger:[button tag]];
        [des setValue:buttonTag forKey:@"buttonTag"];
        [des setValue:button.titleLabel.text forKey:@"buttonText"];
        [des setValue:_chordsMediator forKey:@"chordsMediator"];
    }
}

#pragma mark - Ui action

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [_chordsMediator changeEditingMode];
}

- (void)chordButtonClick:(UIButton*)sender {
    [_chordsMediator chordButtonClick:sender];
}

#pragma mark - Private

- (void)setupButtonsTextWithChordsArray:(NSArray *)chordsArray {
    self.chordButtons = [self.chordButtons sortByObjectTag];
    for (int i = 0; i < [self.chordButtons count]; i++) {
        [[self.chordButtons objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%@", chordsArray[i]] forState:UIControlStateNormal];
    }
}

@end
