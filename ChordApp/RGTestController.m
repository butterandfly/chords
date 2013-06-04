//
//  RGTestController.m
//  ChordApp
//
//  Created by Zero on 13-2-28.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTestController.h"
#import "RGQuester.h"
#import "RGPlayerController.h"
#import "RGHelper.h"

@interface RGTestController () {
    // a quester that deal all the quest stuff
    RGQuester *_quester;
    // music player controller
    RGPlayerController *_pc;
}

- (void)initQuestUI;

- (void)setupAnswerButtons;

- (void)showAnswerLabelByChose:(BOOL)isCorrect;

- (void)setAnswerButtonsEnableState:(BOOL)isEnable;

- (void)setAlaph4AnswerButtons:(float)alpha;

- (NSString*)rightOrWrongMessageByIsCorrect:(BOOL)isCorrect;


@end

@implementation RGTestController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init
    _quester = [[RGQuester alloc] initWithLevel:self.bigLevel andQuestType:self.questType];
    _pc = [RGPlayerController sharedPlayerController];
    
    // Whis is this?
    [self initQuestUI];
    
    // setup and play
    [_pc setupCurrentPlayerByMusic:_quester.currentMusic];
    [_pc playCurrentMusic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
    if ([[segue identifier] isEqualToString:@"finishTest"]) {
        UIViewController *des = [segue destinationViewController];
        NSNumber *score = [NSNumber numberWithInteger:_quester.score];
        [des setValue:score forKey:@"score"];
        [des setValue:self.delegate forKey:@"delegate"];
    }
}

#pragma mark - IBAction methods

- (IBAction)next:(id)sender {
    // check if had answered quest
    if (!_quester.haveAnswered) {
        NSString* tipMsg = NSLocalizedString(@"PLEASESELECT", nil);
        [[[UIAlertView alloc] initWithTitle:tipMsg message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    // stop music
    [_pc stopCurrentMusic];
    
    // if it's the end of the text
    if (_quester.currentQuestNum + 1 == _quester.questSum) {
        [self performSegueWithIdentifier:@"finishTest" sender:self];
        return;
    }
    
    // animation
    [UIView animateWithDuration:1.0 animations:^{
        // disappear all the things
        [self setAlaph4AnswerButtons:0];
        self.answerLabel.alpha = 0;
        self.isCorrectLabel.alpha = 0;
        
    } completion:^(BOOL finished) {
        // step quest number, then init next quest
        _quester.currentQuestNum++;
        // init next question
        [_quester setupAQuest];
        
        // setup ui
        self.answerLabel.alpha = 1;
        self.isCorrectLabel.alpha = 1;
        [self initQuestUI];
        
        // show all the things
        [UIView animateWithDuration:1.5 animations:^{
            // show all answer buttons
            [self setAlaph4AnswerButtons:1];
            // check if it's the last quest
            if (_quester.currentQuestNum + 1 == _quester.questSum) {
                [self.nextButton setTitle:NSLocalizedString(@"FINISH", nil) forState:UIControlStateNormal];
            }
            
        } completion:^(BOOL finished) {
            // play music
            [_pc setupCurrentPlayerByMusic:_quester.currentMusic];
            [_pc playCurrentMusic];
        }];
    }];
    
}

// replay button
- (IBAction)repaly:(id)sender {
    [_pc playCurrentMusic];
}

// cancle button
- (IBAction)cancleTest:(id)sender {
    [_pc stopCurrentMusic];
    if (self.delegate) {
        [self.delegate dismissViewControllerAnimated:YES completion:nil];
    }
}

// answer button
- (void)selectAnswer:(id)sender {
    [_pc stopCurrentMusic];
    // Set haveAnswered token.
    _quester.haveAnswered = YES;
    
    BOOL isCorrect = NO;
    NSString *selected = ((UIButton*)sender).titleLabel.text;
    if ([selected isEqualToString:_quester.correctAnswer]) {
        isCorrect = YES;
        _quester.score++;
    }
    
    [RGHelper showOkAlertWithTitle:[self rightOrWrongMessageByIsCorrect:isCorrect] message:nil];
    [self showAnswerLabelByChose:isCorrect];
    // Disable buttons.
    [self setAnswerButtonsEnableState:NO];
}

#pragma mark - Privated methods

- (void)initQuestUI {
    self.answerLabel.hidden = YES;
    self.isCorrectLabel.hidden = YES;
    self.questTestLabel.text = _quester.questText;
    [self setupAnswerButtons];
}

- (void)setupAnswerButtons {
    // get answer array and set answer buttons
    for (int i = 0; i < 4; i++) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
        UIButton *currentButton = [self valueForKey:buttonName];
        currentButton.enabled = YES;
        [currentButton setTitle:_quester.answers4Buttons[i] forState:UIControlStateNormal];
    }
    
}

// This function show the answer and right or wrong.
// Parameter is that if you have the correct answer.
- (void)showAnswerLabelByChose:(BOOL)isCorrect {
    self.answerLabel.text =[NSString stringWithFormat:NSLocalizedString(@"ANSWER", nil), _quester.correctAnswer];
    if (isCorrect) {
        self.isCorrectLabel.text = NSLocalizedString(@"CORRECT", nil);
        self.isCorrectLabel.textColor = [UIColor greenColor];
    } else {
        self.isCorrectLabel.text = NSLocalizedString(@"WRONG", nil);
        self.isCorrectLabel.textColor = [UIColor redColor];
    }
    
    self.answerLabel.hidden = NO;
    self.isCorrectLabel.hidden = NO;
}

- (void)setAnswerButtonsEnableState:(BOOL)isEnable {
    for (int i = 0; i < 4; i++) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
        UIButton *currentButton =  [self valueForKey:buttonName];
        currentButton.enabled = isEnable;
    }
}

- (void)setAlaph4AnswerButtons:(float)alaph {
    for (int i = 0; i < 4; i++) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
        UIButton *currentButton =  [self valueForKey:buttonName];
        currentButton.alpha = alaph;
    }
}

- (NSString *)rightOrWrongMessageByIsCorrect:(BOOL)isCorrect {
    if (isCorrect) {
        return NSLocalizedString(@"CORRECT", nil);
    }
    return NSLocalizedString(@"WRONG", nil);
}

@end
