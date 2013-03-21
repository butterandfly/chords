//
//  RGQuester.m
//  ChordApp
//
//  Created by Zero on 13-3-9.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGQuester.h"

#include "RGConstants.h"

@interface RGQuester () {
    NSDictionary *_data;
    NSMutableArray *_questCords;
    // 10 quests
    NSMutableArray *_questMusic;
    //
}

- (void)baseInit;


- (void)setupQuestion;

- (void)setupAnswers;

- (void)setupMissingTypeAnswers;

- (void)setupGoingTypeAnswers;

@end

@implementation RGQuester

- (id)initWithLevel:(NSInteger)bigLevel andQuestType:(NSInteger)questType {
    if (self = [super init]) {
        //
        self.bigLevel = bigLevel;
        self.questType = questType;
        [self baseInit];
        [self setupAQuest];
    }
    return self;
}

//
- (id)init {
    return nil;
}

- (void)baseInit {
    _score = 0;
    _questSum = 10;
    _currentQuestNum = 0;
    
    // get data from property file
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"chords_data" ofType:@"plist"];
    _data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    _questMusic = [[NSMutableArray alloc] init];
    
    NSArray *levels;
    switch (self.bigLevel) {
        case 1:
            //
            levels = @[@3, @3, @3, @1];
            break;
        case 2:
            levels = @[@2, @2, @3, @3];
            break;
        case 3:
            levels = @[@1, @2, @2, @5];
            break;
            
        default:
            levels = @[@3, @3, @3, @1];
            break;
    }
    
    for (int i = 0; i < [levels count]; i++) {
        //
        NSString *chordsName = [NSString stringWithFormat:@"chords_%d", (i+1)];
        NSMutableArray *crtLevelMusicArray = [[NSMutableArray alloc] initWithArray:[_data objectForKey:chordsName]];
        
        for (int j = 0; j < [levels[i] intValue]; j++) {
            int randomNum = arc4random() % [crtLevelMusicArray count];
            NSDictionary *chord = [crtLevelMusicArray objectAtIndex:randomNum];
            [_questMusic addObject:chord];
            [crtLevelMusicArray removeObject:chord];
        }
    }
    
//    NSLog(@"%@", _questMusic);
}

- (void)setupAQuest {
    _haveAnswered = NO;
    
    [self setupQuestion];
    [self setupAnswers];
}

- (void)setupQuestion {
    _currentChord = [_questMusic objectAtIndex:_currentQuestNum];
    self.currentMusic = [_currentChord objectForKey:@"name"];
    
    if (self.questType == kMissingChord) {
        //
        NSArray *componentChordArray = [[self.currentChord objectForKey:@"name"] componentsSeparatedByString:@"_"];
        self.correctAnswer = componentChordArray[1];
        self.questText = [[[_data objectForKey:@"questType"] objectAtIndex:self.questType] stringByReplacingOccurrencesOfString:@"\%chord" withString:componentChordArray[0]];
    }
    if (self.questType == kGoingChord) {
        //
        self.correctAnswer = [_currentChord objectForKey:@"name"];
        self.questText = [[_data objectForKey:@"questType"] objectAtIndex:self.questType];
    }
}

- (void)setupAnswers {
    switch (self.questType) {
        case kGoingChord:
            //
            [self setupGoingTypeAnswers];
            break;
        case kMissingChord:
            //
            [self setupMissingTypeAnswers];
            break;
        default:
            [self setupGoingTypeAnswers];
            break;
    }
}

- (void)setupGoingTypeAnswers {
    NSMutableArray *answer4Buttons = [[NSMutableArray alloc] init];
    
    // better way to get answerArray
    NSString *answerLevel = [NSString stringWithFormat:@"chords_%@", [self.currentChord objectForKey:@"level"]];
    NSArray *chordsArray = [NSArray arrayWithArray:[_data objectForKey:answerLevel]];
    NSMutableArray *answerArray = [[NSMutableArray alloc] init];
    for (NSDictionary* aChord in chordsArray) {
        [answerArray addObject:[aChord objectForKey:@"name"]];
    }
    
    BOOL isSetTheCorrect = NO;
    for (int i = 0; i < 4; i++) {
        int randomAnswerNum = arc4random() % [answerArray count];
        NSString *anAnswer = [answerArray objectAtIndex:(randomAnswerNum)];
        [answerArray removeObject:anAnswer];
        [answer4Buttons addObject:anAnswer];
        if ([anAnswer isEqualToString:self.currentMusic]) {
            isSetTheCorrect = YES;
        }
    }
    
    // set correct answer if not exist
    if (!isSetTheCorrect) {
        [answer4Buttons setObject:self.currentMusic atIndexedSubscript:(arc4random()%4)];
    }
    
    self.answers4Button = answer4Buttons;
}

-  (void)setupMissingTypeAnswers {
    NSMutableArray *answer4Buttons = [[NSMutableArray alloc] init];
    NSMutableArray *answerArray = [NSMutableArray arrayWithArray:[_data objectForKey:@"chord_c"]];
    
    BOOL isSetTheCorrect = NO;
    for (int i = 0; i < 4; i++) {
        int randomAnswerNum = arc4random() % [answerArray count];
        NSString *anAnswer = [answerArray objectAtIndex:(randomAnswerNum)];
        [answerArray removeObject:anAnswer];
        [answer4Buttons addObject:anAnswer];
        if ([anAnswer isEqualToString:self.correctAnswer]) {
            isSetTheCorrect = YES;
        }
    }
    
    // set correct answer if not exist
    if (!isSetTheCorrect) {
        [answer4Buttons setObject:self.correctAnswer atIndexedSubscript:(arc4random()%4)];
    }
    
    self.answers4Button = answer4Buttons;
}

@end
