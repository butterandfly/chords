//
//  RGListeningController.m
//  ChordApp
//
//  Created by Zero on 13-2-23.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGListeningController.h"
#import "RGPlayerController.h"

@interface RGListeningController () {
    RGPlayerController *_pc;
}



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
    
    _pc = [RGPlayerController sharedPlayerController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// ibactions
- (void)playChord:(UIButton*)sender {
    // stop playing music
    [_pc stopCurrentMusic];
    
    // get the name of the selected chord
    NSString *selectedChord = sender.titleLabel.text;
    NSString *musicName = [NSString stringWithFormat:@"%@_chord", selectedChord];
    // play
    [_pc setupCurrentPlayerByMusic:musicName];
    [_pc playCurrentMusic];
}

@end
