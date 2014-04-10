//
//  EKBHeap.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/30/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKBHeap.h"

@interface EKBHeap ()

@property (nonatomic, strong) NSMutableArray *heap;

@end


@implementation EKBHeap

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.heap = [@[] mutableCopy];
        [self.heap insertObject:@-1 atIndex:0];
    }
    return self;
}

- (void)insertNumber:(NSNumber *)num
{
    [self.heap addObject:num];
    for (NSUInteger i = [self.heap count] - 1; [num isLessThan:[self.heap objectAtIndex:i/2]]; i /= 2) {
        [self.heap exchangeObjectAtIndex:i withObjectAtIndex:i/2];
    }
}

- (NSNumber *)deleteMin
{
    NSUInteger child, i;
    if ([self isEmpty]) {
        NSAssert(self.heap.count > 1, @"Binary heap is empty");
        return nil;
    } else {
        NSNumber *minNum = [[self.heap objectAtIndex:1] copy];
        NSNumber *lastNum = [self.heap lastObject];
        for (i = 1; i * 2 <= self.heap.count-1; i = child) {
            child = i * 2;
            if (child != self.heap.count-1 && [[self.heap objectAtIndex:child+1] isLessThan:[self.heap objectAtIndex:child]]) {
                child++;
            }
            if ([lastNum isGreaterThan:[self.heap objectAtIndex:child]]) {
                [self.heap exchangeObjectAtIndex:i withObjectAtIndex:child];
            } else
                break;
        }
        [self.heap replaceObjectAtIndex:i withObject:lastNum];
        [self.heap removeLastObject];
        return minNum;
    }
}

- (BOOL)isEmpty
{
    return self.heap.count <= 1 ? YES : NO;
}
@end
