//
//  RGPlayController.m
//  ChordApp
//
//  Created by Zero on 13-3-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGPlayerController.h"
#import "RGAppUserDefaults.h"
#import "RGConstants.h"
#import "RGHelper.h"

@interface RGPlayerController () {
//    NSMutableDictionary *_playMap;
    NSMutableArray *_playerArray;
}

@end

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
    }
    return self;
}

#pragma mark - Public method

- (void)playCurrentMusic {
    if (self.currentPlayer == nil) {
        return;
    }
    
    [self stopCurrentMusic];
    
    [self.currentPlayer setCurrentTime:0];
    [self.currentPlayer play];
}

- (void)stopCurrentMusic {
    if (self.currentPlayer) {
        [self.currentPlayer stop];
    }
}

- (void)setupCurrentPlayerByMusic:(NSString *)music {
    self.currentMusic = music;
    
    self.currentPlayer = [self musicPlayerByMusicFile:music];
}

- (void)setupAndPlayCurrentPlayerByMusicFile:(NSString *)musicFile {
    [self setupCurrentPlayerByMusic:musicFile];
    [self playCurrentMusic];
}

- (void)setupButtonChords {
    _playerArray = [[NSMutableArray alloc] init];
    
    NSArray *chordsArray = [RGAppUserDefaults chordsArray];
    int count = [chordsArray count];
    for (int i = 0; i < count; i++) {
        AVAudioPlayer *player = [self createAChordPlayerByChord:[chordsArray objectAtIndex:i]];
        _playerArray[i] = player;
    }
}

- (void)playByButtonTag:(NSInteger)tag {
    AVAudioPlayer *player = [_playerArray objectAtIndex:(tag-1)];
    
    self.currentPlayer = player;
    [self playCurrentMusic];
}

- (void)changeButtonPlayerByTag:(NSInteger)tag desChord:(NSString *)desChord {
    AVAudioPlayer *player = [self createAChordPlayerByChord:desChord];
    _playerArray[(tag - 1)] = player;
}

- (AVAudioPlayer*)createAChordPlayerByChord:(NSString*)chord {
    NSString *chordName = [NSString stringWithFormat:@"%@_chord", chord];
    
    return [self musicPlayerByMusicFile:chordName];
}

- (AVAudioPlayer *)musicPlayerByMusicFile:(NSString *)musicFile {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:musicFile ofType:kFileTypeMp3];
    NSURL *musicUrl = [[NSURL alloc] initFileURLWithPath:musicPath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    player.volume = 1;
    return player;
}

- (void)releasePlayersArray {
    _playerArray = nil;
}

- (void)recreatePlayersArray {
    [self setupButtonChords];
}

@end
