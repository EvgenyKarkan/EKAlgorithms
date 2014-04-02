//
//  NSArray+Selection.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 06/03/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


@interface NSArray (Selection)

@end


@interface NSMutableArray (Selection)

/**
 Quickselect

 This implementation is based on http://en.wikipedia.org/wiki/Quickselect#Algorithm

 @note Assumes array of NSUInteger values
 @note Performs partial sorting of receiver: all elements before resulting index are less than element with that index, all elements after are greater than element with that index

 @param left Left boundary to search K smallest element within
 @param right Right boundary to search K smallest element within
 @param K the number of smallest element to find

 @warning All arguments: left, right and K are zero-based.

 @code
 For array of 10 elements given K = 4, left = 0, right = 9:
 [9, 7, 10, 6, 4, 2, 5, 1, 3, 8] -> [1, 2, 3, 4, 5, 7, 6, 9, 10, 8]
 Result is: 4 - which is the index of element @(5)
 @endcode

 @return Index of Nth smallest element in partially sorted array. Also, later by that index you may obtain the element which is the smallest Kth element in the original array (before partial sorting).
 */
- (NSUInteger)selectKthSmallestElement:(NSUInteger)left right:(NSUInteger)right K:(NSUInteger)K;

@end

