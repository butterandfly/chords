//
//  RGAppUserDefaults.h
//  ChordApp
//
//  Created by Zero on 13-6-5.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGAppUserDefaults : NSObject

+ (NSArray*)chordsArray;

+ (void)setChordsArray:(NSArray*)chordsArray;

@end
