//
//  RGHelper.h
//  ChordApp
//
//  Created by Zero on 13-6-1.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGHelper : NSObject

+ (NSDictionary*)plistDictByFileName:(NSString*)filename;

+ (NSMutableArray*)localizedArrayFromKeysArray:(NSArray*)keysArray;

+ (id)objectFromUserDefaultsByKey:(NSString*)key;

+ (void)setUserDefaultsObject:(id)object byKey:(NSString*)key;

+ (void)logDashWith:(NSString*)msg;

+ (void)showOkAlertWithTitle:(NSString*)title message:(NSString*)msg;
@end
