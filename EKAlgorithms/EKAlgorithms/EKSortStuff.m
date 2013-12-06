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
	[self mergeArray:unsortedArray withMinimalIndex:0 withMaximumIndex:[unsortedArray count] - 1];
	
	return unsortedArray;
}

+ (void)mergeArray:(NSMutableArray *)arrayToPartition withMinimalIndex:(NSUInteger)minIndex withMaximumIndex:(NSUInteger)maxIndex
{
	NSUInteger mid;
	if (minIndex < maxIndex) {
		mid = (minIndex + maxIndex) / 2;
		[self mergeArray:arrayToPartition withMinimalIndex:minIndex withMaximumIndex:mid];
		[self mergeArray:arrayToPartition withMinimalIndex:mid + 1 withMaximumIndex:maxIndex];
		[self mergeArray:arrayToPartition withMinimalIndex:minIndex withMediumIndex:mid withMaximalIndex:maxIndex];
	}
}

+ (void)mergeArray:(NSMutableArray *)arrayToMerge withMinimalIndex:(NSUInteger)minIndex withMediumIndex:(NSUInteger)midIndex withMaximalIndex:(NSUInteger)maxIndex
{
	NSMutableArray *temporaryArray = [NSMutableArray array];
	
	NSInteger j = minIndex,
              m = midIndex + 1;
	
	while (j <= midIndex && m <= maxIndex) {
		if ([arrayToMerge[j] compare:arrayToMerge[m]] == NSOrderedSame || [arrayToMerge[j] compare:arrayToMerge[m]] == NSOrderedAscending) {
			[temporaryArray addObject:arrayToMerge[j]];
			j++;
		}
		else {
			[temporaryArray addObject:arrayToMerge[m]];
			m++;
		}
	}
    
	if (j > midIndex) {
		while (m <= maxIndex) {
			[temporaryArray addObject:arrayToMerge[m++]];
		}
	}
	else {
		while (j <= midIndex) {
			[temporaryArray addObject:arrayToMerge[j++]];
		}
	}
    
    NSUInteger tempIndex = 0;
	while (minIndex <= maxIndex) {
		[arrayToMerge replaceObjectAtIndex:minIndex++ withObject:temporaryArray[tempIndex++]];
	}
}

#pragma mark - Quick sort

+ (NSMutableArray *)quickSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray withLeftIndex:(NSInteger)left withRightIndex:(NSInteger)right
{
	NSInteger i = 0, j = 0;
	id x = nil, y = nil;
	
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
		[self quickSortedArrayWithUnsortedArray:unsortedArray withLeftIndex:left withRightIndex:j];
	}
	if (i < right) {
		[self quickSortedArrayWithUnsortedArray:unsortedArray withLeftIndex:i withRightIndex:right];
	}
	
	return unsortedArray;
}

#pragma mark - Insertion sort

+ (NSMutableArray *)insertionSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	NSInteger a = 0, b = 0;

	id temp = nil;
	
	for (a = 1; a < (NSInteger)[unsortedArray count]; ++a) {
		temp = unsortedArray[a];
		for (b = a - 1; (b >= 0) && ([temp floatValue] < [unsortedArray[b] floatValue]); b--) {
			[unsortedArray replaceObjectAtIndex:b + 1 withObject:unsortedArray[b]];
		}
		unsortedArray[b + 1] = temp;
	}
	
	return unsortedArray;
}

#pragma mark - Selection sort

+ (NSMutableArray *)selectionSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	for (NSUInteger i = 0; i < [unsortedArray count] - 1; i++) {
		NSUInteger min = i;
		for (NSUInteger j = i + 1; j < [unsortedArray count]; j++) {
			if ([unsortedArray[j] floatValue]  < [unsortedArray[min] floatValue]) {
				min = j;
			}
		}
		id tempObject = unsortedArray[i];
		unsortedArray[i] = unsortedArray[min];
		unsortedArray[min] = tempObject;
	}
    
	return [unsortedArray copy];
}

#pragma mark - Heap sort

+ (void)siftDownArray:(NSMutableArray *)array withStart:(NSInteger)startIndex end:(NSInteger)endIndex
{
	NSInteger root = startIndex;
    
	while ((root * 2 + 1) <= endIndex) {
		NSInteger child = root * 2 + 1;
        
		if (child + 1 <= endIndex && [array[child] integerValue] < [array[child + 1] integerValue]) {
			child++;
		}
        
		if ([array[root] floatValue] < [array[child] floatValue]) {
			[array exchangeObjectAtIndex:root withObjectAtIndex:child];
			root = child;
		}
		else {
			return;
		}
	}
}

+ (void)heapifyArray:(NSMutableArray *)array withSize:(NSInteger)size
{
	NSInteger start = (size - 2) / 2;
    
	while (start >= 0) {
		[self siftDownArray:array withStart:start end:size - 1];
		start--;
	}
}

+ (NSMutableArray *)heapSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	[self heapifyArray:unsortedArray withSize:[unsortedArray count]];
    
	NSInteger end = [unsortedArray count] - 1;
    
	while (end > 0) {
		[unsortedArray exchangeObjectAtIndex:end withObjectAtIndex:0];
		[self siftDownArray:unsortedArray withStart:0 end:end - 1];
		end--;
	}
    
	NSMutableArray *sortedArray = [unsortedArray copy];
    
	return sortedArray;
}

@end
