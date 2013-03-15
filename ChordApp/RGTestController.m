//
//  RGTestController.m
//  ChordApp
//
//  Created by Zero on 13-2-28.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTestController.h"
#import "RGQuester.h"

@interface RGTestController () {
    AVAudioPlayer *_player;
    NSString *_musicType;
    //
    RGQuester *_quester;
}

@property (weak, nonatomic) UIViewController *delegate;

- (void)playCurrentMusic;

- (void)setupPlayer;

- (void)setupAnswerButtons;

- (void)showAnswerLabelByChose:(BOOL)isCorrect;

- (void)setAnswerButtonsEnableState:(BOOL)isEnable;

@end

@implementation RGTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    _musicType = @"mp3";
    
    // setup quester
    _quester = [[RGQuester alloc] init];
    
    
    // setup ui
    self.answerLabel.hidden = YES;
    self.isCorrectLabel.hidden = YES;
    
    [self setupAnswerButtons];
    [self setupPlayer];
    [self playCurrentMusic];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"finishTest"]) {
        UIViewController *des = [segue destinationViewController];
        NSNumber *score = [NSNumber numberWithInteger:_quester.score];
        [des setValue:score forKey:@"score"];
//        des.score = score;
        [des setValue:self.delegate forKey:@"delegate"];
    }
}

#pragma mark - IBAction methods

- (IBAction)next:(id)sender {
    // check if had answered quest
    if (!_quester.haveAnswered) {
        [[[UIAlertView alloc] initWithTitle:@"请选择答案" message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        return;
    }
    
    // if it's the end of the text
    if (_quester.currentQuestNum + 1 == _quester.questSum) {
        [self performSegueWithIdentifier:@"finishTest" sender:self];
        return;
    }
    
    // animation
    [UIView animateWithDuration:1.0 animations:^{
        // disappear all the things
        
        for (int i = 0; i < 4; i++) {
            NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
            UIButton *currentButton =  [self valueForKey:buttonName];
            currentButton.alpha = 0;
        }
        
        self.answerLabel.alpha = 0;
        self.isCorrectLabel.alpha = 0;
        
    } completion:^(BOOL finished) {
        // step quest number, then init next quest
        _quester.currentQuestNum++;
        // here, init next question
        [_quester setupAQuest];
        [self setupAnswerButtons];
        
        self.answerLabel.alpha = 1;
        self.isCorrectLabel.alpha = 1;
        self.answerLabel.hidden = YES;
        self.isCorrectLabel.hidden = YES;
        
        // show all the things
        [UIView animateWithDuration:1.5 animations:^{
            // show all answer buttons
            for (int i = 0; i < 4; i++) {
                NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
                UIButton *currentButton =  [self valueForKey:buttonName];
                currentButton.alpha = 1;
            }
            // check if it's the last quest
            if (_quester.currentQuestNum + 1 == _quester.questSum) {
                [self.nextButton setTitle:@"完成" forState:UIControlStateNormal];
            }
            
        } completion:^(BOOL finished) {
            // play music
            [self setupPlayer];
            [self playCurrentMusic];
        }];
    }];
    
}

- (IBAction)repaly:(id)sender {
    [self playCurrentMusic];
}

- (IBAction)cancleTest:(id)sender {
    if (self.delegate) {
        [self.delegate dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)selectAnswer:(id)sender {
    // stop music
    [_player stop];
    // set token
    _quester.haveAnswered = YES;
    
    // alert message and disappear label
    BOOL isCorrect = NO;
    NSString *selected = ((UIButton*)sender).titleLabel.text;
    NSString *message;
    if ([selected isEqualToString:_quester.currentMusic]) {
        isCorrect = YES;
        _quester.score++;
        message = @"正确！";
    }else {
        isCorrect = NO;
        message = @"错误！";
    }
    [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
    [self showAnswerLabelByChose:isCorrect];
    
    // disable buttons
    [self setAnswerButtonsEnableState:NO];
}

#pragma mark - privated methods

- (void)playCurrentMusic {
    if (_player == nil) {
        // alert or something
        NSLog(@"no music here");
        return;
    }
    
//    NSLog(@"is the music playing: %d", _player.playing);
    if (_player.playing ) {
    
        [_player stop];
    }
    
    // play music
    [_player setCurrentTime:0];
    [_player play];
}

- (void)setupPlayer {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:_quester.currentMusic ofType:_musicType];
    NSURL *musicUrl = [[NSURL alloc] initFileURLWithPath:musicPath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    _player.volume = 1;
    
    NSLog(@"%@", musicUrl);
}

- (void)setupAnswerButtons {
    // get answer array and set answer buttons
    for (int i = 0; i < 4; i++) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
        UIButton *currentButton = [self valueForKey:buttonName];
        currentButton.enabled = YES;
        [currentButton setTitle:_quester.answers4Button[i] forState:UIControlStateNormal];
    }
    
}

- (void)showAnswerLabelByChose:(BOOL)isCorrect {
    self.answerLabel.text =[NSString stringWithFormat:@"正确答案：%@", _quester.currentMusic ];
    if (isCorrect) {
        self.isCorrectLabel.text = @"选择正确";
        self.isCorrectLabel.textColor = [UIColor greenColor];
    } else {
        self.isCorrectLabel.text = @"选择错误";
        self.isCorrectLabel.textColor = [UIColor redColor];
    }
    
    self.answerLabel.hidden = NO;
    self.isCorrectLabel.hidden = NO;
}

#pragma mark - helping privated method

- (void)setAnswerButtonsEnableState:(BOOL)isEnable {
    for (int i = 0; i < 4; i++) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
        UIButton *currentButton =  [self valueForKey:buttonName];
        currentButton.enabled = isEnable;
    }
}

@end
