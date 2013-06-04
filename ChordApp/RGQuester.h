//
//  RGQuester.h
//  ChordApp
//
//  Created by Zero on 13-3-9.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

// RGQuest controller a text, including the quest and answers.
@interface RGQuester : NSObject

@property (strong, nonatomic) NSMutableArray *answers4Buttons;
@property (nonatomic) NSString *currentMusic;
@property (nonatomic) BOOL *haveAnswered;
@property (nonatomic) NSInteger questSum;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger currentQuestNum;
@property (nonatomic) NSDictionary *currentChord;
@property (assign, nonatomic) NSInteger bigLevel;
@property (strong, nonatomic) NSString *correctAnswer;
@property (assign, nonatomic) NSInteger questType;
@property (strong, nonatomic) NSString *questText;

- (id)initWithLevel:(NSInteger)bigLevel andQuestType:(NSInteger) questType;
- (void)setupAQuest;

@end
