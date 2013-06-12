//
//  RGPlayController.h
//  ChordApp
//
//  Created by Zero on 13-3-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface RGPlayerController : NSObject

@property (nonatomic) NSString *currentMusic;
@property (nonatomic) AVAudioPlayer *currentPlayer;

+ (id)sharedPlayerController;

- (void)playCurrentMusic;
- (void)stopCurrentMusic;
- (void)setupCurrentPlayerByMusic:(NSString*) music;
- (void)setupAndPlayCurrentPlayerByMusicFile:(NSString*)musicFile;

- (void)playByButtonTag:(NSInteger)tag;
- (void)setupButtonChords;

- (AVAudioPlayer*)musicPlayerByMusicFile:(NSString*)musicFile;

- (void)changeButtonPlayerByTag:(NSInteger)tag desChord:(NSString*)desChord;

//- (void)releasePlayersInMap;
- (void)releasePlayersArray;

//- (void)recreatePlayersInMap;
- (void)recreatePlayersArray;

@end
