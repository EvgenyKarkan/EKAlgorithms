//
//  EKBHeap.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/30/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKBHeap.h"

#if TARGET_OS_IPHONE
#import "NSNumber+EKComparisonForIOS.h"
#endif


@interface EKBHeap ()

@property (nonatomic, strong) NSMutableArray *heap;

@end


@implementation EKBHeap;

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _heap = [@[] mutableCopy];
        [self.heap insertObject:@-1 atIndex:0];
    }
    return self;
}

- (void)insertNumber:(NSNumber *)num
{
    [self.heap addObject:num];
    
    for (NSUInteger i = [self.heap count] - 1; [num isLessThan:(self.heap)[i / 2]]; i /= 2) {
        [self.heap exchangeObjectAtIndex:i withObjectAtIndex:i / 2];
    }
}

- (NSNumber *)deleteMin
{
    NSUInteger child, i;
    if ([self isEmpty]) {
        NSAssert(self.heap.count > 1, @"Binary heap is empty");
        return nil;
    }
    else {
        NSNumber *minNum  = [(self.heap)[1] copy];
        NSNumber *lastNum = [self.heap lastObject];
        
        for (i = 1; i * 2 <= self.heap.count - 1; i = child) {
            child = i * 2;
            if (child != self.heap.count - 1 && [(self.heap)[child + 1] isLessThan:(self.heap)[child]]) {
                child++;
            }
            if ([lastNum isGreaterThan:(self.heap)[child]]) {
                [self.heap exchangeObjectAtIndex:i withObjectAtIndex:child];
            }
            else
                break;
        }
        (self.heap)[i] = lastNum;
        [self.heap removeLastObject];
        
        return minNum;
    }
}

- (BOOL)isEmpty
{
    return self.heap.count <= 1 ? YES : NO;
}

@end
