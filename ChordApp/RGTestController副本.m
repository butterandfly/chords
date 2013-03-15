//
//  RGTestController.m
//  ChordApp
//
//  Created by Zero on 13-2-28.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTestController.h"

@interface RGTestController () {
    NSDictionary *_data;
    NSDictionary *_currentChord;
    NSMutableArray *_questCords;
    AVAudioPlayer *_player;
    NSString *_currentMusic;
    NSString *_musicType;
    // 10 quests
    NSMutableArray *_questMusic;
    
    NSInteger _currentQuestNum;
    BOOL _haveAnswered;
    NSInteger _questSum;
    NSInteger _score;
}

@property (weak, nonatomic) UIViewController *delegate;

- (void)playCurrentMusic;

- (void)setupPlayer;

- (void)baseInit;

- (void)initSingleTest;

- (void)initQuestion;

- (void)initAnswerButtons;

- (void)beginTest;

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
    
    /*
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"chords_data" ofType:@"plist"];
    _data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    _musicType = @"mp3";
     */
    
    
    [self baseInit];
    [self initSingleTest];
    [self setupPlayer];
    [self playCurrentMusic];
    
//    _currentQuestNum = 8;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"finishTest"]) {
        UIViewController *des = [segue destinationViewController];
        NSNumber *score = [NSNumber numberWithInteger:_score];
        [des setValue:score forKey:@"score"];
//        des.score = score;
        [des setValue:self.delegate forKey:@"delegate"];
    }
}

#pragma mark - IBAction methods

- (IBAction)next:(id)sender {
    // check if had answered quest
    if (!_haveAnswered) {
        [[[UIAlertView alloc] initWithTitle:@"请选择答案" message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        return;
    }
    
    // if it's the end of the text
    if (_currentQuestNum + 1 == _questSum) {
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
        _currentQuestNum++;
        [self initSingleTest];
        self.answerLabel.alpha = 1;
        self.isCorrectLabel.alpha = 1;
        
        // show all the things
        [UIView animateWithDuration:1.5 animations:^{
            // show all answer buttons
            for (int i = 0; i < 4; i++) {
                NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
                UIButton *currentButton =  [self valueForKey:buttonName];
                currentButton.alpha = 1;
            }
            // check if it's the last quest
            if (_currentQuestNum + 1 == _questSum) {
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
    _haveAnswered = YES;
    
    // alert message and disappear label
    BOOL isCorrect = NO;
    NSString *selected = ((UIButton*)sender).titleLabel.text;
    NSString *message;
    if ([selected isEqualToString:_currentMusic]) {
        isCorrect = YES;
        _score++;
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
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:_currentMusic ofType:_musicType];
    NSURL *musicUrl = [[NSURL alloc] initFileURLWithPath:musicPath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    _player.volume = 1;
    
    NSLog(@"%@", musicUrl);
}

- (void)baseInit {
    _score = 0;
    _questSum = 10;
    _currentQuestNum = 0;
    // base setting
    _musicType = @"mp3";
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
    NSLog(@"level1music: %@", level1Music);
    
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
    
    NSLog(@"_questMusic: %@", _questMusic);
}

- (void)initSingleTest {
    // hide answer label
    self.answerLabel.hidden = YES;
    self.isCorrectLabel.hidden = YES;
    _haveAnswered = NO;
    
    [self initQuestion];
    [self initAnswerButtons];
}

- (void)initQuestion {
    _currentChord = [_questMusic objectAtIndex:_currentQuestNum];
    NSLog(@"%@", _currentChord);
    _currentMusic = [_currentChord objectForKey:@"name"];
}

- (void)initAnswerButtons {
    // get answer array and set answer buttons
    NSString *answerLevel = [NSString stringWithFormat:@"answers_%@", [_currentChord objectForKey:@"level"]];
    NSLog(@"%@", answerLevel);
    NSMutableArray *answerArray = [[NSMutableArray alloc] initWithArray:[_data objectForKey:answerLevel]];
    NSLog(@"%@", answerArray);
    BOOL isSetTheCorrect = NO;
    for (int i = 0; i < 4; i++) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
        UIButton *currentButton = [self valueForKey:buttonName];
        currentButton.enabled = YES;
        int randomAnswerNum = arc4random() % [answerArray count];
        NSString *anAnswer = [answerArray objectAtIndex:(randomAnswerNum)];
        [answerArray removeObject:anAnswer];
        if ([anAnswer isEqualToString:_currentMusic]) {
            //
            isSetTheCorrect = YES;
            NSLog(@"Here is the answer.");
        }
        [currentButton setTitle:anAnswer forState:UIControlStateNormal];
    }
    
    // set correct answer if not exist
    if (!isSetTheCorrect) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", (arc4random()%4)];
        UIButton *currentButton = [self valueForKey:buttonName];
        [currentButton setTitle:_currentMusic forState:UIControlStateNormal];
        NSLog(@"Now we set the correct answer.");
    }
}

- (void)beginTest {
    [self initSingleTest];
    [self setupPlayer];
    [self playCurrentMusic];
}

- (void)showAnswerLabelByChose:(BOOL)isCorrect {
    self.answerLabel.text =[NSString stringWithFormat:@"正确答案：%@", _currentMusic ];
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

- (void)setAnswerButtonsEnableState:(BOOL)isEnable {
    for (int i = 0; i < 4; i++) {
        NSString *buttonName = [NSString stringWithFormat:@"anwserButton%d", i];
        UIButton *currentButton =  [self valueForKey:buttonName];
        currentButton.enabled = isEnable;
    }
}

@end
