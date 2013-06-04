//
//  RGPlayController.m
//  ChordApp
//
//  Created by Zero on 13-3-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGPlayerController.h"

@interface RGPlayerController () {
    NSMutableDictionary *_playMap;
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
        // init
        _musicType = @"mp3";
//        _playMap = [[NSMutableDictionary alloc] init];
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
    if (self.currentPlayer != nil && self.currentPlayer.playing) {
        [self.currentPlayer stop];
    }
}

- (void)setupCurrentPlayerByMusic:(NSString *)music {
    self.currentMusic = music;
    
    self.currentPlayer = [self musicPlayerByMusicFile:music];
    self.currentPlayer.volume = 1;
}

- (void)setupAndPlayCurrentPlayerByMusicFile:(NSString *)musicFile {
    [self setupCurrentPlayerByMusic:musicFile];
    [self playCurrentMusic];
}

- (void)setupButtonChords {
    //
    _playMap = [[NSMutableDictionary alloc] init];
    
    // * Get chords array from user defaulst.
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSArray *chordsArray = [settings objectForKey:@"chords"];
    // First time to run the app.
    if (chordsArray == nil) {
        // Setup array.
        chordsArray = @[@"C", @"F", @"G", @"Am", @"Em", @"Dm", @"G7", @"D", @"E"];
        [settings setObject:chordsArray forKey:@"chords"];
    }
    
    [self setupMapByArray:chordsArray];
}

- (void)setupMapByArray:(NSArray *)chordsArray {
    if ([chordsArray count] != 9) {
        //
        return;
    }
    
    // Loop the array.
    for (NSString *chord in chordsArray) {
        // setup player
        AVAudioPlayer *player = [self createAChordPlayerByChord:chord];
        player.volume = 1;
        [_playMap setObject:player forKey:chord];
    }
    
//    NSLog(@"setup finished...\nthe map is: %@", _playMap);
}

- (void)playFromMapByChordName:(NSString *)chord {
    AVAudioPlayer *player = [_playMap objectForKey:chord];
    if (player == nil) {
        return;
    }
    
    self.currentPlayer = player;
    self.currentMusic = chord;
    [self playCurrentMusic];
//    [self stopCurrentMusic];
//    [self.currentPlayer setCurrentTime:0];
//    [self.currentPlayer play];
}

- (void)resetMapFromChord:(NSString*)srcChord toChord:(NSString *)desChord {
    [_playMap removeObjectForKey:srcChord];
    
    AVAudioPlayer *player = [self createAChordPlayerByChord:desChord];
    [_playMap setObject:player forKey:desChord];
}

- (AVAudioPlayer*)createAChordPlayerByChord:(NSString*)chord {
    NSString *chordName = [NSString stringWithFormat:@"%@_chord", chord];
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:chordName ofType:self.musicType];
    NSLog(@"now we get the path: %@", musicPath);
    NSURL *musicUrl = [[NSURL alloc] initFileURLWithPath:musicPath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    return player;
}

- (AVAudioPlayer *)musicPlayerByMusicFile:(NSString *)musicFile {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:musicFile ofType:self.musicType];
    NSURL *musicUrl = [[NSURL alloc] initFileURLWithPath:musicPath];
    
    return [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
}

@end
