//
//  RGListeningController.m
//  ChordApp
//
//  Created by Zero on 13-2-23.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGListeningController.h"

@interface RGListeningController ()


@end

@implementation RGListeningController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ibactions
- (void)playChord:(UIButton*)sender {
    // playing chord code
    NSString *selectedChord = sender.titleLabel.text;
    //text
    NSLog(@"You select %@ chord...", selectedChord);
    
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSString *fileName = [NSString stringWithFormat:@"%@_chord", selectedChord];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    NSURL *fileUrl = [[NSURL alloc] initFileURLWithPath:filePath];
    NSLog(@"%@", fileUrl);
    
    NSError *playErr;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&playErr];
//    [self.player prepareToPlay];
    self.player.volume = 1;
//    [self.player prepareToPlay];
    [self.player play];
//    [self.player stop];
    NSLog(@"%@", playErr);
}

@end
