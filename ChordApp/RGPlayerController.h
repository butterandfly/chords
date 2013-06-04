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
@property (nonatomic) NSString *musicType;

+ (id)sharedPlayerController;

- (void)playCurrentMusic;
- (void)stopCurrentMusic;
- (void)setupCurrentPlayerByMusic:(NSString*) music;
- (void)setupAndPlayCurrentPlayerByMusicFile:(NSString*)musicFile;

- (void)playFromMapByChordName:(NSString*)chord;
- (void)setupMapByArray:(NSArray*)chordsArray;
- (void)setupButtonChords;

- (AVAudioPlayer*)musicPlayerByMusicFile:(NSString*)musicFile;

- (void)resetMapFromChord:(NSString*)srcChord toChord:(NSString*)desChord;

@end
