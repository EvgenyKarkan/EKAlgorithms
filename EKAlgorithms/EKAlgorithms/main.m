//
//  main.m
//  EKAlgorithms
//
//  Created by Каркан Евгений on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKSearch.h"
#import "EKSort.h"
#import "EKArray.h"

int main(int argc, const char *argv[])
{
	@autoreleasepool {
		
			//Linear search
		NSLog(@"Linear search result: %li", (long)[EKSearch indexOfObjectViaLinearSearchForObject:@42 inArray:@[@6, @9, @12, @13, @14, @29, @42]]);
		
			//Binary search
		NSLog(@"Binary search result: %li", (long)[EKSearch inedxOfObjectViaBinarySearchForObject:@42 inSortedArray:@[@6, @9, @12, @13, @14, @29, @42]]);
		
			//Init array with 5 random elements
		NSMutableArray *array = [NSMutableArray array];
		for (int i = 0; i < 5; i++) {
			[array addObject:[NSNumber numberWithInt:arc4random() % 20]];
		}
		
			//Max element of array
		NSLog(@"Max element of created array %@ is equals to %@ and stored at index %li",[array debugDescription],
			  [array objectAtIndex:(long)[EKArray indexOfMaximumElementInArray:array]],
			  (long)[EKArray indexOfMaximumElementInArray:array]);

			//Bubble sort
		NSLog(@"Bubble sorted array is: %@", [EKSort bubbleSortedArrayWithUnsortedArray:array]);
		
		
	}
	return 0;
}

