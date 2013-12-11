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

/**
 Get the Max and Min Simultaneously.

 Original idea: http://tristan-interview.blogspot.com/2012/02/get-max-and-min-simultaneously.html

 @note Assumes array of NSInteger values

 @return NSArray with two elements: indexes of elements with minimal/maximal values respectively or nil if receiver array is empty
 */
- (NSArray *)indexesOfMinimumAndMaximumElements;

- (NSString *)longestString;
- (NSString *)shortestString;

- (NSArray *)reversedArray;
- (NSArray *)CocoaImplementationOfReversedArray;

- (NSArray *)intersectionWithArray:(NSArray *)secondArray;
- (NSArray *)unionWithoutDuplicatesWithArray:(NSArray *)secondArray;
- (BOOL)hasDuplicates;
+ (NSArray *)randomObjectsWithArraySize:(NSUInteger)arraySize maxRandomValue:(NSUInteger)maxValue uniqueObjects:(BOOL)unique;
- (BOOL)isSorted;

/**
 Array Shuffle (Fisher–Yates)

 Source: http://ruby-doc.org/core-2.0.0/Array.html#method-i-shuffle-21

 @return Array with elements of original array in a randomized order
 */
- (NSArray *)shuffledArray;

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
