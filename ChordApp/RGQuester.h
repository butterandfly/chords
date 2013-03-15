//
//  RGQuester.h
//  ChordApp
//
//  Created by Zero on 13-3-9.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGQuester : NSObject

@property (nonatomic) NSArray *answers4Button;
@property (nonatomic) NSString *currentMusic;
@property (nonatomic) BOOL *haveAnswered;
@property (nonatomic) NSInteger questSum;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger currentQuestNum;
@property (nonatomic) NSDictionary *currentChord;

- (id)initWithPlistPath:(NSString*)path;
- (void)setupAQuest;

@end
