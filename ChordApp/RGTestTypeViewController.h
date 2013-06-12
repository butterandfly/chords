//
//  RGTestTypeViewController.h
//  ChordApp
//
//  Created by Zero on 13-3-18.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGPrepareTestController.h"

// RGTestTypeViewController shows the config of test category.
@interface RGTestTypeViewController : UITableViewController

@property (assign, nonatomic) NSInteger questType;
@property (weak, nonatomic) RGPrepareTestController* configDelegate;
@property (strong, nonatomic) NSMutableArray *categoryArray;

@end
