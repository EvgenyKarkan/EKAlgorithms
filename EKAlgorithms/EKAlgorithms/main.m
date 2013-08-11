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

int main(int argc, const char *argv[])
{
	@autoreleasepool {
		
			//Linear search
		NSLog(@"Linear search result: %li", (long)[EKSearch linearSearchForObject:@42 inArray:@[@45, @26, @125, @42]]);
		
			//Bubble sort
		NSLog(@"Bubble sorted result: %@", [EKSort bubbleSortedArrayWithUnsortedArray:[NSMutableArray arrayWithObjects:@4.5, @17.4, @12, @27, @6, @1, @0.5, nil]]);
		
			//Binary search
		NSLog(@"Binary search result: %li", (long)[EKSearch binarySearchForObject:@42 inSortedArray:[NSArray arrayWithObjects:@6, @9, @12, @13, @14, @29, @42, nil]]);
	}
	return 0;
}

