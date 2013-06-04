//
//  RGQuester.m
//  ChordApp
//
//  Created by Zero on 13-3-9.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGQuester.h"
#import "RGDataCenter.h"
#import "RGHelper.h"

#import "RGConstants.h"

@interface RGQuester () {
    // 10 quests
    NSMutableArray *_questArray;
    //
    RGDataCenter *_dataCenter;
}

- (void)baseInit;

- (void)setupCorrectAnswer;
- (void)setupAnswers;
- (void)setupAnswersWithQuestCate:(NSInteger)cate;
- (void)setupAnswers4ButtonsWithAnswersArray:(NSMutableArray *)answerArray;
- (void)setupQuestArray;
- (void)setupQuestText;
    
- (NSString*)questTextByCateKey:(NSInteger)cateKey;
- (NSArray*)levelArray;
- (NSMutableArray*)mutableArrayOfQuestTextInLevel:(NSInteger)level;
    
@end

@implementation RGQuester

#pragma mark - Public

- (id)initWithLevel:(NSInteger)bigLevel andQuestType:(NSInteger)questType {
    if (self = [super init]) {
        //
        _dataCenter = [RGDataCenter sharedDataCenter];
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

- (void)setupAQuest {
    _haveAnswered = NO;
    
    _currentChord = [_questArray objectAtIndex:_currentQuestNum];
    self.currentMusic = [_currentChord objectForKey:@"name"];
    [self setupQuestText];
    [self setupCorrectAnswer];
    [self setupAnswers];
}

#pragma mark - Privated

- (void)baseInit {
    _score = 0;
    _questSum = 10;
    _currentQuestNum = 0;
    
    [self setupQuestArray];
}

- (void)setupQuestText {
    self.questText = [self questTextByCateKey:self.questType];
    
    if (self.questType == kQuestCateMissingChod) {
        NSArray *componentChordArray = [[self.currentChord objectForKey:@"name"] componentsSeparatedByString:@"_"];
        self.questText = [self.questText stringByReplacingOccurrencesOfString:@"\%chord" withString:componentChordArray[0]];
    }
}

- (void)setupAnswers {
    [self setupAnswersWithQuestCate:self.questType];
}

- (void)setupAnswersWithQuestCate:(NSInteger)cate {
    NSMutableArray *answerArray;
    
    // Get anwers for each type of quest.
    if (cate == kQuestCateChordsProgression) {
        // Get all answer in the same level.
        answerArray = [self mutableArrayOfQuestTextInLevel:[[self.currentChord objectForKey:@"level"] integerValue]];
    }
    if (cate == kQuestCateMissingChod) {
        // Get all chords in C majay.
        answerArray = [NSMutableArray arrayWithArray:[[RGDataCenter sharedDataCenter] objectFromChordsDataByKey:@"chord_c"]];
    }
    
    [self setupAnswers4ButtonsWithAnswersArray:answerArray];
}

- (NSArray*)levelArray {
    NSArray *levels;
    switch (self.bigLevel) {
        case 1:
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
    
    return levels;
}

- (NSMutableArray*)mutableArrayOfQuestTextInLevel:(NSInteger)level {
    NSMutableArray *questTextArray = [[NSMutableArray alloc] init];
    NSString *questLevel = [NSString stringWithFormat:@"chords_%d", level];
    NSArray *questArrayInLevel = [NSArray arrayWithArray:[[RGDataCenter sharedDataCenter] objectFromChordsDataByKey: questLevel]];
    for (NSDictionary* aQuestDict in questArrayInLevel) {
        [questTextArray addObject:[aQuestDict objectForKey:@"name"]];
    }
    return questTextArray;
}

- (void)setupAnswers4ButtonsWithAnswersArray:(NSMutableArray *)answerArray {
    self.answers4Buttons = [[NSMutableArray alloc] init];

    BOOL isSetTheCorrect = NO;
    // Add answer to the answer4Buttons.
    for (int i = 0; i < 4; i++) {
        int randomAnswerNum = arc4random() % [answerArray count];
        NSString *anAnswer = [answerArray objectAtIndex:randomAnswerNum];
        [answerArray removeObject:anAnswer];
        [self.answers4Buttons addObject:anAnswer];
        if ([anAnswer isEqualToString:self.correctAnswer]) {
            isSetTheCorrect = YES;
        }
    }
    // Set correct answer if not exist.
    if (!isSetTheCorrect) {
        [self.answers4Buttons setObject:self.correctAnswer atIndexedSubscript:(arc4random()%4)];
    }
}

- (NSString*)questTextByCateKey:(NSInteger)cateKey {
    NSArray *questCateTextArray = [[RGDataCenter sharedDataCenter] objectFromChordsDataByKey:kPlistQuestCatesText];
    return NSLocalizedString([questCateTextArray objectAtIndex:cateKey], nil);
}

- (void)setupCorrectAnswer {
    self.correctAnswer = [_currentChord objectForKey:@"name"];
    
    if (self.questType == kQuestCateMissingChod) {
        NSArray *componentChordArray = [self.correctAnswer componentsSeparatedByString:@"_"];
        self.correctAnswer = componentChordArray[1];
    }
}

- (void)setupQuestArray {
    _questArray = [[NSMutableArray alloc] init];
    
    // Make sure you have set the bigLevel.
    NSArray *levels = [self levelArray];
    
    for (int i = 0; i < [levels count]; i++) {
        // Get each level's quests.
        NSString *questLevelName = [NSString stringWithFormat:@"chords_%d", (i+1)];
        NSMutableArray *crtLevelMusicArray = [[NSMutableArray alloc] initWithArray:[[RGDataCenter sharedDataCenter] objectFromChordsDataByKey:questLevelName]];
        
        // Set up each level's quests.
        for (int j = 0; j < [levels[i] intValue]; j++) {
            int randomNum = arc4random() % [crtLevelMusicArray count];
            NSDictionary *chord = [crtLevelMusicArray objectAtIndex:randomNum];
            [_questArray addObject:chord];
            [crtLevelMusicArray removeObject:chord];
        }
    }
}

@end
