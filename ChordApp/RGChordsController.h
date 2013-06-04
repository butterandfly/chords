//
//  RGChordsController.h
//  ChordApp
//
//  Created by Zero on 13-4-12.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGChordsController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chordButtons;
@property (assign, nonatomic) BOOL isEditing;

- (IBAction)chordButtonClick:(UIButton*)sender;

@end
