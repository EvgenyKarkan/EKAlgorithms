//
//  NSMutableArray+EKStuff.m
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSMutableArray+EKStuff.h"

@implementation NSMutableArray (EKStuff);


#pragma mark - Used in merge sort

- (void)partitionArrayWithMinimalIndex:(NSInteger)min withMaximumIndex:(NSInteger)max
{
    NSInteger mid = 0;
    
    if (min < max) {
        mid = (min + max) / 2;
        [self partitionArrayWithMinimalIndex:min withMaximumIndex:mid];
        [self partitionArrayWithMinimalIndex:mid + 1 withMaximumIndex:max];
        [self mergeArrayWithMinimalIndex:min withMediumIndex:mid withMaximalIndex:max];
    }
}

- (void)mergeArrayWithMinimalIndex:(NSInteger)min withMediumIndex:(NSInteger)mid withMaximalIndex:(NSInteger)max
{
    NSMutableArray *temporaryArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self count]; i++) {
        [temporaryArray addObject:[NSNull null]];
    }
    
    NSInteger i = 0, j = 0, k = 0, m = 0;
    j = min;
    m = mid + 1;
    
    for (i = min; j <= mid && m <= max; i++) {
        if ([[self objectAtIndex:j] floatValue] <= [[self objectAtIndex:m] floatValue]) {
            [temporaryArray replaceObjectAtIndex:i withObject:[self objectAtIndex:j]];
            j++;
        }
        else {
            [temporaryArray replaceObjectAtIndex:i withObject:[self objectAtIndex:m]];
            m++;
        }
    }
    if (j > mid) {
        for (k = m; k <= max; k++) {
            [temporaryArray replaceObjectAtIndex:i withObject:[self objectAtIndex:k]];
            i++;
        }
    }
    else {
        for (k = j; k <= mid; k++) {
            [temporaryArray replaceObjectAtIndex:i withObject:[self objectAtIndex:k]];
            i++;
        }
    }
    for (k = min; k <= max; k++) {
        [self replaceObjectAtIndex:k withObject:[temporaryArray objectAtIndex:k]];
    }
}

#pragma mark - Used in heap sort

- (void)siftDownArrayWithStart:(NSInteger)startIndex end:(NSInteger)endIndex
{
    NSInteger root = startIndex;
    
    while ((root * 2 + 1) <= endIndex) {
        NSInteger child = root * 2 + 1;
        
        if (child + 1 <= endIndex && [self[child] floatValue] < [self[child + 1] floatValue]) {
            child++;
        }
        
        if ([self[root] floatValue] < [self[child] floatValue]) {
            [self exchangeObjectAtIndex:root withObjectAtIndex:child];
            root = child;
        }
        else {
            return;
        }
    }
}

- (void)heapifyArrayWithSize:(NSInteger)size
{
    NSInteger start = (size - 2) / 2;
    
    while (start >= 0) {
        [self siftDownArrayWithStart:start end:size - 1];
        start--;
    }
}

@end
