//
//  RGListeningController.h
//  ChordApp
//
//  Created by Zero on 13-2-23.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RGListeningController : UIViewController

@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)playChord:(UIButton*)sender;

@end
