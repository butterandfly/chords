//
//  RGPrepareTestController.h
//  ChordApp
//
//  Created by Zero on 13-3-2.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGPrepareTestController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigLevelLabel;

@property (strong, nonatomic) NSIndexPath *typeIndex;
@property (assign, nonatomic) NSInteger questType;
@property (assign, nonatomic) NSInteger bigLevel;

- (IBAction)levelChange:(UIStepper*)sender;
@end
