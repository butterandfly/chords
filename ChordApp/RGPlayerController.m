//
//  RGPlayController.m
//  ChordApp
//
//  Created by Zero on 13-3-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGPlayerController.h"

@implementation RGPlayerController


+ (id)sharedPlayerController{
    __strong static id _sharedPlayerController = nil;
    static dispatch_once_t pre;
    dispatch_once(&pre, ^{
        _sharedPlayerController = [[self alloc] init];
    });
    return _sharedPlayerController;
}

- (id)init {
    self = [super init];
    if (self) {
        // init
        _musicType = @"mp3";
    }
    return self;
}

- (void)playCurrentMusic {
    if (self.currentPlayer == nil) {
        // alert or something
        return;
    }
    
    // stop music
    [self stopCurrentMusic];
    // play music
    [self.currentPlayer setCurrentTime:0];
    [self.currentPlayer play];
}

- (void)stopCurrentMusic {
    if (self.currentPlayer != nil && self.currentPlayer.playing) {
        [self.currentPlayer stop];
    }
}

- (void)setupCurrentPlayerByMusic:(NSString *)music {
    if (music != nil) {
        self.currentMusic = music;
    }
    
    if (self.currentMusic == nil) {
        return;
    }
    
    // get the url of music
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:self.currentMusic ofType:self.musicType];
    NSURL *musicUrl = [[NSURL alloc] initFileURLWithPath:musicPath];
    
    self.currentPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    self.currentPlayer.volume = 1;
}

@end
