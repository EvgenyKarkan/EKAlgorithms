//
//  NSArray+EKStuff.h
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface NSArray (EKStuff)


/**
 Get the index of maximum element in array.

 @note Assumes array of NSNumber values

 @return Index of maximum element in array
 */
- (NSUInteger)indexOfMaximumElement;


/**
 Get the Max and Min Simultaneously.

 Original idea: http://tristan-interview.blogspot.com/2012/02/get-max-and-min-simultaneously.html

 @note Assumes array of NSNumber values

 @return NSArray with two elements: indexes of elements with minimal/maximal values respectively or nil if receiver array is empty
 */
- (NSArray *)indexesOfMinimumAndMaximumElements;

- (NSString *)longestString;
- (NSString *)shortestString;

- (NSArray *)intersectionWithArray:(NSArray *)secondArray;
- (NSArray *)unionWithoutDuplicatesWithArray:(NSArray *)secondArray;
- (NSArray *)unionWithoutDuplicatesWithArray:(NSArray *)secondArray forKey:(NSString *)currentKey;
- (BOOL)hasDuplicates;
+ (NSArray *)randomObjectsWithArraySize:(NSUInteger)arraySize maxRandomValue:(NSUInteger)maxValue uniqueObjects:(BOOL)unique;


/**
 Sum of array elements

 @note Assumes array of long long values

 @return NSNumber with long long int value
 */
- (NSNumber *)sumOfElements;

- (NSDictionary *)occurencesOfEachElementInArray_naive;
- (NSDictionary *)occurencesOfEachElementInArray;
- (NSDictionary *)CocoaImplementationOfOccurencesOfEachElementInArray;

//search

- (NSInteger)indexOfObjectViaLinearSearch:(id)object;
- (NSInteger)indexOfObjectViaBinarySearch:(id)object;

@end
