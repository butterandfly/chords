//
//  RGChordsMediator.h
//  ChordApp
//
//  Created by Zero on 13-4-14.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGChordsController.h"

@interface RGChordsMediator : NSObject

@property RGChordsController *chordsController;

+ (id)sharedChordsMediator;

- (void)chordButtonClick:(id)sender;

- (void)changeEditingMode;

- (void)changeChordByTag:(NSInteger)tag srcChord:(NSString*)srcChord desChord:(NSString*)desChord;

@end
