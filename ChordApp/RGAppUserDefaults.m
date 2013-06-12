//
//  RGAppUserDefaults.m
//  ChordApp
//
//  Created by Zero on 13-6-5.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGAppUserDefaults.h"
#import "RGHelper.h"
#import "RGConstants.h"

@implementation RGAppUserDefaults

+ (NSArray *)chordsArray {
    NSArray *chordsArray = [RGHelper objectFromUserDefaultsByKey:kSettingChordsArray];
    if (chordsArray == nil) {
        // Default array.
        chordsArray = @[@"C", @"F", @"G", @"Am", @"Em", @"Dm", @"G7", @"D", @"E"];
        [RGHelper setUserDefaultsObject:chordsArray byKey:kSettingChordsArray];
    }
    return chordsArray;
}

+ (void)setChordsArray:(NSArray *)chordsArray {
    [RGHelper setUserDefaultsObject:chordsArray byKey:kSettingChordsArray];
}

@end
