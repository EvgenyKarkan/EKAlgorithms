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
		NSLog(@"Linear search result: %li", (long)[EKSearch indexOfObjectViaLinearSearchForObject:@42 inArray:@[@45, @26, @125, @42]]);
		
			//Bubble sort
		NSLog(@"Bubble sorted result: %@", [EKSort bubbleSortedArrayWithUnsortedArray:[NSMutableArray arrayWithObjects:@4.5, @17.4, @12, @27, @6, @1, @0.5, nil]]);
		
			//Binary search
		NSLog(@"Binary search result: %li", (long)[EKSearch inedxOfObjectViaBinarySearchForObject:@42 inSortedArray:@[@6, @9, @12, @13, @14, @29, @42]]);
		
			//Max element of array
		NSMutableArray *array = [NSMutableArray array];
		for (int i = 0; i < 5; i++) {
			[array addObject:[NSNumber numberWithInt:arc4random() % 20]];
		}
		NSLog(@"Max element of created array %@ is equals to %@ and stored at index %li",[array debugDescription],
																						 [array objectAtIndex:(long)[EKArray indexOfMaximumElementInArray:array]],
																						 (long)[EKArray indexOfMaximumElementInArray:array]);
	}
	return 0;
}

