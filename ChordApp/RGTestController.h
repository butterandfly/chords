//
//  RGTestController.h
//  ChordApp
//
//  Created by Zero on 13-2-28.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RGTestController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *anwserButton0;
@property (strong, nonatomic) IBOutlet UIButton *anwserButton1;
@property (strong, nonatomic) IBOutlet UIButton *anwserButton2;
@property (strong, nonatomic) IBOutlet UIButton *anwserButton3;
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;
@property (strong, nonatomic) IBOutlet UILabel *isCorrectLabel;

- (IBAction)next:(id)sender;
- (IBAction)repaly:(id)sender;
- (IBAction)cancleTest:(id)sender;
- (IBAction)selectAnswer:(id)sender;
@end
