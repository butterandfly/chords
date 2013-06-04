//
//  RGDataCenter.h
//  ChordApp
//
//  Created by Zero on 13-6-2.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGDataCenter : NSObject

+ (RGDataCenter*)sharedDataCenter;

- (NSDictionary*)chordsData;
- (id)objectFromChordsDataByKey:(id)key;

@end
