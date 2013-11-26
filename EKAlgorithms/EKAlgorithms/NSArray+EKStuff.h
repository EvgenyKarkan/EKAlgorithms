//
//  NSArray+EKStuff.h
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (EKStuff)

- (NSUInteger)indexOfMaximumElement;
- (NSString *)longestString;
- (NSString *)shortestString;
- (NSArray *)reversedArray;
- (NSArray *)intersectionWithArray:(NSArray *)secondArray;
- (NSArray *)unionWithoutDuplicatesWithArray:(NSArray *)secondArray;
- (BOOL)hasDuplicates;
+ (NSArray *)randomObjectsWithArraySize:(NSUInteger)arraySize maxRandomValue:(NSUInteger)maxValue uniqueObjects:(BOOL)unique;

//search

- (NSInteger)indexOfObjectViaLinearSearch:(id)object;
- (NSInteger)indexOfObjectViaBinarySearch:(id)object;

//sort

- (NSMutableArray *)bubbleSortedArray;
- (NSMutableArray *)shellSortedArray;
- (NSMutableArray *)mergeSortedArray;
- (NSMutableArray *)quickSortedArrayWithLeftIndex:(NSInteger)left withRightIndex:(NSInteger)right;
- (NSMutableArray *)insertionSortedArray;
- (NSMutableArray *)selectionSortedArray;
- (NSMutableArray *)heapSortedArray;

@end
