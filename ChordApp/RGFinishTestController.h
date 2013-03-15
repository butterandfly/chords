//
//  RGFinishTestController.h
//  ChordApp
//
//  Created by Zero on 13-3-8.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGFinishTestController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *scoreMessage;
@property (nonatomic) NSNumber *score;
@property (nonatomic) UIViewController *delegate;

- (IBAction)finish:(id)sender;
@end
