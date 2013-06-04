//
//  RGChordSettingController.h
//  ChordApp
//
//  Created by Zero on 13-4-14.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGChordsMediator.h"

@interface RGChordSettingController : UITableViewController

@property (assign, nonatomic) NSInteger buttonTag;
@property (strong, nonatomic) NSString *buttonText;

@property (weak, nonatomic) RGChordsMediator *chordsMediator;

@end
