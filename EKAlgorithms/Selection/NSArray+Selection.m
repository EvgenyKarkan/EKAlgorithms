//
//  NSArray+Selection.m
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 06/03/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "NSArray+Selection.h"

@implementation NSArray (Selection)

@end


@implementation NSMutableArray (Selection)

#pragma mark - SELECTION STUFF
#pragma mark - Quickselect

- (NSUInteger)selectNthSmallestElement_partition:(NSUInteger)left right:(NSUInteger)right pivotIndex:(NSUInteger)pivotIndex
{
    NSUInteger pivotValue = [self[pivotIndex] unsignedIntegerValue];
    
    [self exchangeObjectAtIndex:pivotIndex withObjectAtIndex:right];
    
    NSUInteger storeIndex = left;
    
    for (NSUInteger i = left; i < right; i++) {
        if ([self[i] unsignedIntegerValue] <= pivotValue) {
            [self exchangeObjectAtIndex:storeIndex withObjectAtIndex:i];
            
            storeIndex++;
        }
    }
    
    [self exchangeObjectAtIndex:right withObjectAtIndex:storeIndex];
    
    return storeIndex;
}

- (NSUInteger)selectKthSmallestElement:(NSUInteger)left right:(NSUInteger)right K:(NSUInteger)K
{
    if (left == right) {
        return left;
    }
    
    do {
        NSUInteger pivotIndex = left + arc4random_uniform((uint32_t)(right - left + 1));
        
        pivotIndex = [self selectNthSmallestElement_partition:left right:right pivotIndex:pivotIndex];
        
        if (K == pivotIndex) {
            return K;
        }
        
        else if (K < pivotIndex) {
            right = pivotIndex - 1;
        }
        
        else {
            left = pivotIndex + 1;
        }
    }
    while (1);
}

@end
