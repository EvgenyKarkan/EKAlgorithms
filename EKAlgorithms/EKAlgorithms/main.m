//
//  main.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKSearch.h"
#import "EKSort.h"
#import "EKArray.h"
#import "EKString.h"

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
		NSLog(@"Max element of created array %@ is equals to %@ and stored at index %li", [array debugDescription],
			  [array objectAtIndex:(long)[EKArray indexOfMaximumElementInArray:array]],
			  (long)[EKArray indexOfMaximumElementInArray:array]);
		
			//Bubble sort
		NSLog(@"Bubble sorted array is: %@", [EKSort bubbleSortedArrayWithUnsortedArray:array]);
		
			//Shell sort
		NSLog(@"Shell sorted array is %@", [EKSort shellSortedArrayWithUnsortedArray:[NSMutableArray arrayWithArray:@[@2, @45, @8, @1, @27, @16, @5.3, @ - 53.7]]]);
		
			//Merge sort
		NSLog(@"Merge sorted array %@", [EKSort mergeSortedArrayWithUnsortedArray:[NSMutableArray arrayWithArray:@[@21, @45, @87, @10, @273, @616, @0.2, @ - 0.52]]]);
		
			//Quick sort numbers
		NSLog(@"Quick sorted array %@", [EKSort quickSortedArrayWithUnsortedArray:[NSMutableArray arrayWithArray:@[@2.1, @405, @817, @10, @2732, @616, @0.2, @ - 0.52]]
																	   withLeftIdx:0
																	  withRightIdx:[[NSMutableArray arrayWithArray:@[@21, @45, @87, @10, @273, @616, @0.2, @ - 0.52]] count] - 1]);
		
			//Insertion sort
		NSLog(@"Insertion sorted array %@", [EKSort insertionSortedArrayWithUnsortedArray:[@[@-23.0154, @46, @0.021, @42, @5, @NO, @YES] mutableCopy]]);
		
			//Palindrome string
		NSLog(@"Palindrome? Answer:%@", [EKString isGivenStringPalindrome:@"Was it a car or a cat I saw"] ? @"YES" : @"NO");
		
			//Longest string from array
		NSLog(@"The longest string is %@", [EKArray longestStringInArray:[@[@"Kiev", @"Moscow", @"Tokyo", @"Saint-Petersburg", @"SanFrancisco"] mutableCopy]]);
		
			//Shortest string from array
		NSLog(@"The shortest string is %@", [EKArray shortestStringInArray:[@[@"DRY", @"KISS", @"YAGNI", @"SOLID", @"GRASP"] mutableCopy]]);
	}
	return 0;
}


