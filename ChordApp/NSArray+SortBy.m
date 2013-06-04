//
//  NSArray+SortBy.m
//  ChordApp
//
//  Created by Zero on 13-4-12.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "NSArray+SortBy.h"

@implementation NSArray (SortBy)

- (NSArray*) sortByObjectTag
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA tag] < [objB tag]) ? NSOrderedAscending  :
               ([objA tag] > [objB tag]) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

- (NSArray*) sortByUIViewOriginX
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA frame].origin.x < [objB frame].origin.x) ? NSOrderedAscending  :
               ([objA frame].origin.x > [objB frame].origin.x) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

- (NSArray*) sortByUIViewOriginY
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA frame].origin.y < [objB frame].origin.y) ? NSOrderedAscending  :
               ([objA frame].origin.y > [objB frame].origin.y) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

/*
- (NSArray *)sortByXandY {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //
        if ([obj1 frame].origin.x < [obj2 frame].origin.x) {
            //
            return NSOrderedAscending;
        }
        if ([obj1 frame].origin.x > [obj2 frame].origin.x) {
            //
            return NSOrderedDescending;
        }
        if ([obj1 frame].origin.x == [obj2 frame].origin.x) {
            //
            if ([obj1 frame].origin.y < [obj2 frame].origin.y) {
                //
                return NSOrderedAscending;
            }
            if ([obj1 frame].origin.y > [obj2 frame].origin.y) {
                //
                return NSOrderedDescending;
            }
            if ([obj1 frame].origin.y == [obj2 frame].origin.y) {
                //
                return NSOrderedSame;
            }
        }
        return NSOrderedAscending;
    }];
}
 */

@end
