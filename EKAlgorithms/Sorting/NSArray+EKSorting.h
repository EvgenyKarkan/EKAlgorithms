//
//  NSArray+EKSorting.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 31/03/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


@interface NSArray (EKSorting)

/**
 Check if array is sorted

 @note Assumes array of NSNumber elements

 @return YES, if array is sorted, and NO otherwise.
 */
- (BOOL)isSorted;

- (NSArray *)CocoaImplementationOfReversedArray;

@end


@interface NSMutableArray (EKSorting)

- (NSMutableArray *)reverse;


/**
 Array Shuffle (Fisher–Yates)

 Source: http://ruby-doc.org/core-2.0.0/Array.html#method-i-shuffle-21
 */
- (NSMutableArray *)shuffle;


/**
 Bubble Sort (naive N * N version)
 */
- (NSMutableArray *)naiveBubbleSort;

/**
 Bubble Sort (better (N * N) / 2 version)
 */
- (NSMutableArray *)bubbleSort;


- (NSMutableArray *)shellSort;
- (NSMutableArray *)mergeSort;
- (NSMutableArray *)quickSortWithLeftIndex:(NSInteger)left withRightIndex:(NSInteger)right;
- (NSMutableArray *)insertionSort;
- (NSMutableArray *)selectionSort;
/**
 Radix Sort
 
 Thanks to https://github.com/PlenipotentSS/RadixSort this project
 
 */
- (NSMutableArray *)radixSortForBase:(NSInteger)base;

/**
 Partial selection sort

 This implementation is based on http://en.wikipedia.org/wiki/Selection_algorithm#Partial_selection_sort

 @note Assumes array of NSUInteger values

 @param K Number of first K elements to sort

 Example:
 @code
 N = 10, K = 5
 [9, 7, 10, 6, 4, 2, 5, 1, 3, 8] -> [1, 2, 3, 4, 5, 7, 6, 9, 10, 8]
 @endcode
 */
- (NSMutableArray *)partialSelectionSort:(NSUInteger)K;

- (NSMutableArray *)heapSort;


@end


@interface NSMutableArray (EKSortingHelpers)

- (void)partitionArrayWithMinimalIndex:(NSInteger)min withMaximumIndex:(NSInteger)max;

- (void)mergeArrayWithMinimalIndex:(NSInteger)min withMediumIndex:(NSInteger)mid withMaximalIndex:(NSInteger)max;

- (void)siftDownArrayWithStart:(NSInteger)startIndex end:(NSInteger)endIndex;

- (void)heapifyArrayWithSize:(NSInteger)size;

@end
