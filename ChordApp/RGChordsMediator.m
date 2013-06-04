//
//  RGChordsMediator.m
//  ChordApp
//
//  Created by Zero on 13-4-14.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGChordsMediator.h"
#import "RGPlayerController.h"
#import "RGHelper.h"
#import "RGConstants.h"

@interface RGChordsMediator () {
    
}

- (void)goChordSettingView:(id)sender;
- (void)playChord:(id)sender;
- (void)enterEditing;
- (void)leaveEditing;

@end

@implementation RGChordsMediator

+ (id)sharedChordsMediator {
    static RGChordsMediator *sharedChordsMediator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedChordsMediator = [[self alloc] init];
    });
    return sharedChordsMediator;
}

#pragma mark - Public

- (void)chordButtonClick:(id)sender {
    if (self.chordsController.editing) {
        [self goChordSettingView:sender];
        return;
    }
    
    [self playChord:sender];
}

- (void)changeEditingMode {
    if (self.chordsController.isEditing) {
        [self leaveEditing];
    } else {
        [self enterEditing];
    }
}

- (void)changeChordByTag:(NSInteger)tag srcChord:(NSString *)srcChord desChord:(NSString *)desChord {
    UIButton *btn = (UIButton*)[self.chordsController.view viewWithTag:tag];
    [btn setTitle:desChord forState:UIControlStateNormal];
    
    // Save.
    NSMutableArray *chordsArray = [NSMutableArray arrayWithArray:[RGHelper objectFromUserDefaultsByKey:kSettingChordsArray]];
    chordsArray[tag] = desChord;
    [RGHelper setUserDefaultsObject:chordsArray byKey:kSettingChordsArray];
    
    [[RGPlayerController sharedPlayerController] resetMapFromChord:srcChord toChord:desChord];
}

#pragma mark - Privated

- (void)goChordSettingView:(id)sender {
    [self.chordsController performSegueWithIdentifier:@"ChordSetting" sender:sender];
}

- (void)playChord:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSString *selectedChord = btn.titleLabel.text;
    
    [[RGPlayerController sharedPlayerController] playFromMapByChordName:selectedChord];
}

- (void)enterEditing {
    [RGHelper logDashWith:@"enterEditing"];
    NSString *title = NSLocalizedString(@"EDITTIPS", nil);
    self.chordsController.navigationItem.title = title;
    self.chordsController.navigationItem.rightBarButtonItem.tintColor = [UIColor blueColor];
    self.chordsController.isEditing = YES;
}

- (void)leaveEditing {
    [RGHelper logDashWith:@"leaveEditing"];
    NSString *title = NSLocalizedString(@"CHORDS", nil);
    self.chordsController.navigationItem.title = title;
    self.chordsController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.chordsController.isEditing = NO;
}



@end
