//
//  EKSort.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKSortStuff.h"


@implementation EKSortStuff;

#pragma mark - Bubble sort

+ (NSMutableArray *)bubbleSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	id temp = nil;
	
	for (int i = (int)[unsortedArray count] - 2; i >= 0; i--) {
		for (int j = 0; j <= i; j++) {
			if ([unsortedArray[j] integerValue] > [unsortedArray[j + 1] integerValue]) {
				temp = [unsortedArray objectAtIndex:j];
				[unsortedArray replaceObjectAtIndex:j withObject:[unsortedArray objectAtIndex:j + 1]];
				[unsortedArray replaceObjectAtIndex:j + 1 withObject:temp];
			}
		}
	}
	
	return unsortedArray;
}

#pragma mark - Shell sort

+ (NSMutableArray *)shellSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	id temp = nil;
	
	for (NSInteger i = [unsortedArray count] / 2; i > 0; i = i / 2) {
		for (NSInteger j = i; j < [unsortedArray count]; j++) {
			for (NSInteger k = j - i; k >= 0; k = k - i) {
				if ([[unsortedArray objectAtIndex:k + 1] floatValue] >= [[unsortedArray objectAtIndex:k] floatValue]) {
					break;
				}
				else {
					temp = [unsortedArray objectAtIndex:k];
					[unsortedArray replaceObjectAtIndex:k withObject:[unsortedArray objectAtIndex:k + i]];
					[unsortedArray replaceObjectAtIndex:k + i withObject:temp];
				}
			}
		}
	}
	
	return unsortedArray;
}

#pragma mark - Merge sort stuff

+ (NSMutableArray *)mergeSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	[self partitionArray:unsortedArray withMinimalIndex:0 withMaximumIndex:(NSInteger)[unsortedArray count] - 1];
	
	return unsortedArray;
}

+ (void)partitionArray:(NSMutableArray *)arrayToPartition withMinimalIndex:(NSInteger)min withMaximumIndex:(NSInteger)max
{
	NSInteger mid;
	
	if (min < max) {
		mid = (min + max) / 2;
		[self partitionArray:arrayToPartition withMinimalIndex:min withMaximumIndex:mid];
		[self partitionArray:arrayToPartition withMinimalIndex:mid + 1 withMaximumIndex:max];
		[self mergeArray:arrayToPartition withMinimalIndex:min withMediumIndex:mid withMaximalIndex:max];
	}
}

+ (void)mergeArray:(NSMutableArray *)arrayToMerge withMinimalIndex:(NSInteger)min withMediumIndex:(NSInteger)mid withMaximalIndex:(NSInteger)max
{
	NSMutableArray *temporaryArray = [NSMutableArray array];
	
	for (NSInteger i = 0; i < [arrayToMerge count]; i++) {
		[temporaryArray addObject:[NSNull null]];
	}
	
	NSInteger i = 0, j, k, m;
	j = min;
	m = mid + 1;
	
	for (i = min; j <= mid && m <= max; i++) {
		if ([[arrayToMerge objectAtIndex:j] floatValue] <= [[arrayToMerge objectAtIndex:m] floatValue]) {
			[temporaryArray replaceObjectAtIndex:i withObject:[arrayToMerge objectAtIndex:j]];
			j++;
		}
		else {
			[temporaryArray replaceObjectAtIndex:i withObject:[arrayToMerge objectAtIndex:m]];
			m++;
		}
	}
	if (j > mid) {
		for (k = m; k <= max; k++) {
			[temporaryArray replaceObjectAtIndex:i withObject:[arrayToMerge objectAtIndex:k]];
			i++;
		}
	}
	else {
		for (k = j; k <= mid; k++) {
			[temporaryArray replaceObjectAtIndex:i withObject:[arrayToMerge objectAtIndex:k]];
			i++;
		}
	}
	for (k = min; k <= max; k++) {
		[arrayToMerge replaceObjectAtIndex:k withObject:[temporaryArray objectAtIndex:k]];
	}
}

#pragma mark - Quick sort

+ (NSMutableArray *)quickSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray withLeftIdx:(NSInteger)left withRightIdx:(NSInteger)right
{
	NSInteger i, j;
	id x, y;
	
	i = left;
	j = right;
	x = unsortedArray[(left + right) / 2];
	
	do {
		while (([unsortedArray[i] floatValue] < [x floatValue]) && (i < right)) {
			i++;
		}
		while (([x floatValue] < [unsortedArray[j] floatValue]) && (j > left)) {
			j--;
		}
		
		if (i <= j) {
			y = unsortedArray[i];
			[unsortedArray replaceObjectAtIndex:i withObject:unsortedArray[j]];
			unsortedArray[j] = y;
			i++;
			j--;
		}
	}
	while (i <= j);
	
	if (left < j) {
		[self quickSortedArrayWithUnsortedArray:unsortedArray withLeftIdx:left withRightIdx:j];
	}
	if (i < right) {
		[self quickSortedArrayWithUnsortedArray:unsortedArray withLeftIdx:i withRightIdx:right];
	}
	
	return unsortedArray;
}

#pragma mark - Insertion sort

+ (NSMutableArray *)insertionSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	NSInteger a, b;
	id temp;
	
	for (a = 1; a < (NSInteger)[unsortedArray count]; ++a) {
		temp = unsortedArray[a];
		for (b = a - 1; (b >= 0) && ([temp floatValue] < [unsortedArray[b] floatValue]); b--) {
			[unsortedArray replaceObjectAtIndex:b + 1 withObject:unsortedArray[b]];
		}
		unsortedArray[b + 1] = temp;
	}
	
	return unsortedArray;
}

@end
