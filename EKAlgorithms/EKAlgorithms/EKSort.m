//
//  EKSort.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKSort.h"

@implementation EKSort

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

+ (NSMutableArray *)shellSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
{
	id temp = nil;
	
	for (NSInteger i = [unsortedArray count] / 2; i > 0; i = i / 2) {
		for (NSInteger j = i; j < [unsortedArray count]; j++) {
			for (NSInteger k = j - i; k >= 0; k = k - i) {
				if ([unsortedArray objectAtIndex:k + 1] >= [unsortedArray objectAtIndex:k]) {
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

@end
