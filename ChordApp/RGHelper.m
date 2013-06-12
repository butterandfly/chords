//
//  RGHelper.m
//  ChordApp
//
//  Created by Zero on 13-6-1.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGHelper.h"

@implementation RGHelper

+ (NSDictionary *)plistDictByFileName:(NSString *)filename {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:path];
    return dataDict;
}

+ (NSMutableArray *)localizedArrayFromKeysArray:(NSArray*)keysArray {
    NSMutableArray *localizedArray = [NSMutableArray array];
    
    for (NSString *cateKey in keysArray) {
        NSString *category = NSLocalizedString(cateKey, nil);
        [localizedArray addObject:category];
    }
    
    return localizedArray;
}

+ (id)objectFromUserDefaultsByKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+ (void)setUserDefaultsObject:(id)object byKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
}

+ (void)logDashWith:(NSString *)msg {
    NSLog(@"----- %@ -----", msg);
}

+ (void)showOkAlertWithTitle:(NSString*)title message:(NSString*)msg {
    [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
