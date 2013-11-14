//
//  EKArray.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKArrayStuff.h"


@implementation EKArrayStuff;

#pragma mark - Max element in array

+ (NSUInteger)indexOfMaximumElementInArray:(NSArray *)array
{
	id max = [array objectAtIndex:0];
	
	for (NSUInteger i = 1; i < [array count]; i++) {
		if ([array objectAtIndex:i] > max) {
			max = [array objectAtIndex:i];
		}
	}
	
	return [array indexOfObject:max];
}

#pragma mark - Longest string in array

+ (NSString *)longestStringInArray:(NSMutableArray *)array
{
	NSString *returnValue = nil;
	
	for (NSString *string in array) {
		if (returnValue == nil || [string length] > [returnValue length]) {
			returnValue = string;
		}
	}
    
	return returnValue;
}

#pragma mark - Shortest string in array

+ (NSString *)shortestStringInArray:(NSMutableArray *)array
{
	NSString *returnValue = nil;
	
	for (NSString *string in array) {
		if (returnValue == nil || [string length] < [returnValue length]) {
			returnValue = string;
		}
	}
    
	return returnValue;
}

#pragma mark - Array reverse

+ (NSArray *)reversedArrayWithArray:(NSArray *)arrayToReverse
{
	NSMutableArray *reversedArray = [@[] mutableCopy];
    
	for (NSUInteger i = [arrayToReverse count] - 1; i <= [arrayToReverse count]; i--) {
		[reversedArray addObject:arrayToReverse[i]];
	}
    
	return [reversedArray copy];
}

#pragma mark - Intersection of two arrays

+ (NSArray *)intersectionOfArray:(NSArray *)firstArray withArray:(NSArray *)secondArray
{
    NSMutableSet *intersection = [NSMutableSet setWithArray:firstArray];
    [intersection intersectSet:[NSSet setWithArray:secondArray]];
 
    return [intersection allObjects];
}

#pragma mark - Union of two arrays

+ (NSArray *)unionWithoutDuplicatesOfArray:(NSArray *)firstArray withArray:(NSArray *)secondArray
{
	NSSet *firstSet = [NSSet setWithArray:firstArray];
	NSSet *secondSet = [NSSet setWithArray:secondArray];
    
	NSMutableSet *resultSet = [NSMutableSet setWithSet:firstSet];
	[resultSet unionSet:secondSet];
    
	return [resultSet allObjects];
}

#pragma mark - Find duplicates

+ (BOOL)findDuplicatesInArray:(NSArray *)givenArray
{
	for (NSUInteger i = 0; i < [givenArray count]; i++) {
		for (NSUInteger j = i + 1; j < [givenArray count]; j++) {
			if (i != j && [givenArray[i] isEqualTo:givenArray[j]]) {
				return YES;
			}
		}
	}
    
	return NO;
}

@end

