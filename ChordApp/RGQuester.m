//
//  RGQuester.m
//  ChordApp
//
//  Created by Zero on 13-3-9.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGQuester.h"

@interface RGQuester () {
    NSDictionary *_data;
    NSMutableArray *_questCords;
    // 10 quests
    NSMutableArray *_questMusic;
    
    // current things
    
    
    // 
}

- (void)baseInit;


- (void)setupQuestion;

- (void)setupAnswers;

@end

@implementation RGQuester

// don't use this function
- (id)initWithPlistPath:(NSString *)path {
    // init and read data
    if (self = [self init]) {
        // read data
    }
    
    return self;
}

//
- (id)init {
    if (self = [super init]) {
        //
        [self baseInit];
        [self setupAQuest];
    }
    return self;
}

- (void)baseInit {
    _score = 0;
    _questSum = 10;
    _currentQuestNum = 0;
    
    // get data from property file
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"chords_data" ofType:@"plist"];
    _data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    _questMusic = [[NSMutableArray alloc] init];
    
    // count
    int level1 = 4;
    int level2 = 4;
    int level3 = 2;
    
    NSMutableArray *level1Music = [[NSMutableArray alloc] initWithArray:[_data objectForKey:@"chords_1"]];
    NSMutableArray *level2Music = [[NSMutableArray alloc] initWithArray:[_data objectForKey:@"chords_2"]];
    NSMutableArray *level3Music = [[NSMutableArray alloc] initWithArray:[_data objectForKey:@"chords_3"]];
    
    for (int i = 0; i < level1; i++) {
        int randomNum = arc4random() % [level1Music count];
        NSDictionary *chord = [level1Music objectAtIndex:randomNum];
        [_questMusic addObject:chord];
        [level1Music removeObject:chord];
    }
    
    for (int i = 0; i < level2; i++) {
        int randomNum = arc4random() % [level2Music count];
        NSDictionary *chord = [level2Music objectAtIndex:randomNum];
        [_questMusic addObject:chord];
        [level2Music removeObject:chord];
    }
    
    for (int i = 0; i < level3; i++) {
        int randomNum = arc4random() % [level3Music count];
        NSDictionary *chord = [level3Music objectAtIndex:randomNum];
        [_questMusic addObject:chord];
        [level3Music removeObject:chord];
    }
}

- (void)setupAQuest {
    _haveAnswered = NO;
    
    [self setupQuestion];
    [self setupAnswers];
}

- (void)setupQuestion {
    _currentChord = [_questMusic objectAtIndex:_currentQuestNum];
    self.currentMusic = [_currentChord objectForKey:@"name"];
}

- (void)setupAnswers {
    NSMutableArray *answer4Buttons = [[NSMutableArray alloc] init];
    
    // get answer array and set answer buttons
    NSString *answerLevel = [NSString stringWithFormat:@"answers_%@", [_currentChord objectForKey:@"level"]];
    NSMutableArray *answerArray = [[NSMutableArray alloc] initWithArray:[_data objectForKey:answerLevel]];
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

// get answers4Button
//- (NSArray *)answers4Button {
//}

@end
