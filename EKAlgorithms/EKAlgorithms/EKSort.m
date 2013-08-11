//
//  EKSort.m
//  EKAlgorithms
//
//  Created by Каркан Евгений on 11.08.13.
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
	
	NSMutableArray *sortedArray = unsortedArray;
	
	return sortedArray;
}

@end
