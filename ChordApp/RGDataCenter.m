//
//  RGDataCenter.m
//  ChordApp
//
//  Created by Zero on 13-6-2.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGDataCenter.h"
#import "RGHelper.h"
#import "RGConstants.h"

@interface RGDataCenter () {
    NSDictionary *_chordsDataPlist;
}


@end

@implementation RGDataCenter

+ (RGDataCenter *)sharedDataCenter {
    __strong static RGDataCenter *_sharedDataCenter = nil;
    static dispatch_once_t pre;
    dispatch_once(&pre, ^{
        _sharedDataCenter = [[self alloc] init];
    });
    return _sharedDataCenter;
}

- (id)init {
    self = [super init];
    if (self) {
        _chordsDataPlist = [RGHelper plistDictByFileName:kFileChordsDataFile];
    }
    return self;
}

- (id)objectFromChordsDataByKey:(id)key {
    return [_chordsDataPlist objectForKey:key];
}

- (NSDictionary *)chordsData {
    return _chordsDataPlist;
}

@end
