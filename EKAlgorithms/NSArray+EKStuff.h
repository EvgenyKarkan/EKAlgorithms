//
//  NSArray+EKStuff.h
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (EKStuff)


/**
 Get the index of maximum element in array.

 @note Assumes array of NSInteger values

 @return Index of maximum element in array
 */
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

/**
 Sum of array elements

 @note Assumes array of long long values

 @return NSNumber with long long int value
 */
- (NSNumber *)sumOfElements;

- (NSDictionary *)occurencesOfEachElementInArray;
- (NSDictionary *)occurencesOfEachElementInArrayByUsingDictionary;
- (NSDictionary *)CocoaImplementationOfOccurencesOfEachElementInArray;

//search

- (NSInteger)indexOfObjectViaLinearSearch:(id)object;
- (NSInteger)indexOfObjectViaBinarySearch:(id)object;

//sort

- (NSMutableArray *)bubbleSortedArray;
- (NSMutableArray *)shellSortedArray;
- (NSMutableArray *)mergeSortedArray;
- (NSMutableArray *)quickSortedArrayWithLeftIndex:(NSInteger)left withRightIndex:(NSInteger)right;
- (NSMutableArray *)insertionSortedArray;

- (NSArray *)selectionSortedArray;

/**
 Partial selection sort

 This implementation is based on http://en.wikipedia.org/wiki/Selection_algorithm#Partial_selection_sort

 @note Assumes array of NSUInteger values

 @param K Number of first K elements to sort

 @code
 [9, 7, 10, 6, 4, 2, 5, 1, 3, 8] -> [1, 2, 3, 4, 5, 7, 6, 9, 10, 8]
 @endcode

 @return NSArray with first K elements sorted. If K = N / 2 then Kth element of sorted array is a median for both sorted and original arrays
 */
- (NSArray *)partialSelectionSortedArray:(NSUInteger)K;

- (NSMutableArray *)heapSortedArray;

@end
