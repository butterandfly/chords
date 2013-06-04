//
//  RGMidiViewController.m
//  ChordApp
//
//  Created by Zero on 13-5-22.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMidiViewController.h"
#import <AudioToolbox/MusicPlayer.h>

@interface RGMidiViewController () {
    MusicPlayer _p;
    MusicSequence _s;
}

@end

@implementation RGMidiViewController

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

- (IBAction)play:(id)sender {
//    MusicSequence s;
    NewMusicSequence(&_s);
    
    NSString *midPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mid"];
    NSURL *midUrl = [NSURL fileURLWithPath:midPath];
    MusicSequenceFileLoad(_s, (__bridge CFURLRef)(midUrl), 0, 0);
    
//    MusicPlayer p;
    NewMusicPlayer(&_p);
    MusicPlayerSetSequence(_p, _s);
    MusicPlayerPreroll(_p);
    MusicPlayerStart(_p);
    
    /*
    // get time
    MusicTrack t;
    MusicTimeStamp len;
    UInt32 sz = sizeof(MusicTimeStamp);
    MusicSequenceGetIndTrack(s, 1, &t);
    MusicTrackGetProperty(t, kSequenceTrackProperty_TrackLength, &len, &sz);
    
    while (1) { // kill time until the music is over
        usleep (3 * 1000 * 1000);
        MusicTimeStamp now = 0;
        MusicPlayerGetTime (p, &now);
        if (now >= len)
            break;
    }
    
    // final
    MusicPlayerStop(p);
    DisposeMusicPlayer(p);
    DisposeMusicSequence(s);
     */
}

- (IBAction)stop:(id)sender {
    MusicPlayerStop(_p);
    DisposeMusicPlayer(_p);
    DisposeMusicSequence(_s);
}

- (IBAction)sequence:(id)sender {
    OSStatus status = 0;
    
    MusicSequence seq;
    status = NewMusicSequence(&seq);
    [self oopsWithStatus:status msg:@"error to create musicsequence"];
    
    MusicSequenceSetSequenceType(seq, kMusicSequenceType_Seconds);
    
    MusicTrack tempoTrack;
    status = MusicSequenceGetTempoTrack(seq, &tempoTrack);
    [self oopsWithStatus:status msg:@"error to get tempotrack"];
    
    status = MusicTrackNewExtendedTempoEvent(tempoTrack, 0, 60);
    [self oopsWithStatus:status msg:@"error to extend tempotrack"];
    
    MusicTrack chordsTrack;
    status = MusicSequenceNewTrack(seq, &chordsTrack);
    [self oopsWithStatus:status msg:@"error to create chords track"];
    
    for (int i = 0; i < 120; i++) {
        //
        MIDINoteMessage aNote;
        
        aNote.channel = 0;
        aNote.velocity = 60;
        aNote.releaseVelocity = 1;
        aNote.note = 60 + (i%2)*2;
        aNote.duration = 1;
        
        status = MusicTrackNewMIDINoteEvent(chordsTrack, i, &aNote);
        [self oopsWithStatus:status msg:@"error to add note even"];
    }
    
    NewMusicPlayer(&_p);
    MusicPlayerSetSequence(_p, seq);
    MusicPlayerPreroll(_p);
    MusicPlayerStart(_p);
}

- (IBAction)chord:(id)sender {
    [self playWithChordName:@"c"];
}

- (void)oopsWithStatus:(OSStatus)status msg:(NSString*)msg {
    if (status) {
        //
        NSLog(@"%@", msg);
    }
}

- (void)playWithChordName:(NSString*)name {
    OSStatus status = 0;
    
    MusicSequence seq;
    status = NewMusicSequence(&seq);
    [self oopsWithStatus:status msg:@"error to create musicsequence"];
    
    MusicSequenceSetSequenceType(seq, kMusicSequenceType_Seconds);
    
    MusicTrack tempoTrack;
    status = MusicSequenceGetTempoTrack(seq, &tempoTrack);
    [self oopsWithStatus:status msg:@"error to get tempotrack"];
    
    status = MusicTrackNewExtendedTempoEvent(tempoTrack, 0, 60);
    [self oopsWithStatus:status msg:@"error to extend tempotrack"];
    
    MusicTrack chordsTrack;
    status = MusicSequenceNewTrack(seq, &chordsTrack);
    [self oopsWithStatus:status msg:@"error to create chords track"];
    
    NSArray *notes = @[@60, @62, @67];
    for (int i =0; i < 3; i++) {
        //
        MIDINoteMessage aNote;
        
        aNote.channel = 1;
        aNote.velocity = 60;
        aNote.releaseVelocity = 1;
        aNote.note = [notes[i] integerValue];
        aNote.duration = 1;
        
        MusicTrackNewMIDINoteEvent(chordsTrack, 0, &aNote);
    }
    
    NewMusicPlayer(&_p);
    MusicPlayerSetSequence(_p, seq);
    MusicPlayerPreroll(_p);
    MusicPlayerStart(_p);
}

/*
- (NSArray*)getNotesByChordName:(NSString*)name {
    NSMutableArray *noteArray = [NSMutableArray arrayWithCapacity:3];
    NSArray *notes = @[@60, @64, @67];
    for (int i =0; i < 3; i++) {
        //
        MIDINoteMessage aNote;
        
        aNote.channel = 0;
        aNote.velocity = 60;
        aNote.releaseVelocity = 1;
        aNote.note = [notes[i] integerValue];
        aNote.duration = 1;
    }
    
    return nil;
}
 */
@end
