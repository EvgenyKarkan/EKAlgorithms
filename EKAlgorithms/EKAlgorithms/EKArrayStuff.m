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
	
	for (NSString *str in array) {
		if (returnValue == nil || [str length] > [returnValue length]) {
			returnValue = str;
		}
	}
    
	return returnValue;
}

#pragma mark - Longest string in array

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

#pragma mark - Reverse of array

+ (NSArray *)reversedArrayWithArray:(NSArray *)arrayToReverse
{
	NSMutableArray *reversedArray = [@[] mutableCopy];
    
	for (NSUInteger i = [arrayToReverse count] - 1; i <= [arrayToReverse count]; i--) {
		[reversedArray addObject:arrayToReverse[i]];
	}
    
	return [reversedArray copy];
}

@end

