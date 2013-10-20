//
//  main.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKSearchStuff.h"
#import "EKSortStuff.h"
#import "EKArrayStuff.h"
#import "EKStringStuff.h"
#import "EKNumbersStuff.h"
#import "EKStack.h"

int main(int argc, const char *argv[])
{
	@autoreleasepool {
		 
			//Linear search
		NSLog(@"Linear search result: %li", (long)[EKSearchStuff indexOfObjectViaLinearSearchForObject:@42 inArray:@[@6, @9, @12, @13, @14, @29, @42]]);
		
			//Binary search
		NSLog(@"Binary search result: %li", (long)[EKSearchStuff inedxOfObjectViaBinarySearchForObject:@42 inSortedArray:@[@6, @9, @12, @13, @14, @29, @42]]);
		
			//Init array with 5 random elements
		NSMutableArray *array = [NSMutableArray array];
		for (int i = 0; i < 5; i++) {
			[array addObject:[NSNumber numberWithInt:arc4random() % 20]];
		}
		
			//Max element of array
		NSLog(@"Max element of created array %@ is equals to %@ and stored at index %li", [array debugDescription],
			  [array objectAtIndex:(long)[EKArrayStuff indexOfMaximumElementInArray:array]],
			  (long)[EKArrayStuff indexOfMaximumElementInArray:array]);
		
			//Bubble sort
		NSLog(@"Bubble sorted array is: %@", [EKSortStuff bubbleSortedArrayWithUnsortedArray:array]);
		
			//Shell sort
		NSLog(@"Shell sorted array is %@", [EKSortStuff shellSortedArrayWithUnsortedArray:[NSMutableArray arrayWithArray:@[@2, @45, @8, @1, @27, @16, @5.3, @ - 53.7]]]);
		
			//Merge sort
		NSLog(@"Merge sorted array %@", [EKSortStuff mergeSortedArrayWithUnsortedArray:[NSMutableArray arrayWithArray:@[@21, @45, @87, @10, @273, @616, @0.2, @ - 0.52]]]);
		
			//Quick sort numbers
		NSLog(@"Quick sorted array %@", [EKSortStuff quickSortedArrayWithUnsortedArray:[NSMutableArray arrayWithArray:@[@2.1, @405, @817, @10, @2732, @616, @0.2, @ - 0.52]]
																	   withLeftIdx:0
																	  withRightIdx:[[NSMutableArray arrayWithArray:@[@21, @45, @87, @10, @273, @616, @0.2, @ - 0.52]] count] - 1]);
		
			//Insertion sort
		NSLog(@"Insertion sorted array %@", [EKSortStuff insertionSortedArrayWithUnsortedArray:[@[@-23.0154, @46, @0.021, @42, @5, @NO, @YES] mutableCopy]]);
		
			//Palindrome string
		NSLog(@"Palindrome? Answer:%@", [EKStringStuff isGivenStringPalindrome:@"Was it a car or a cat I saw"] ? @"YES" : @"NO");
		
			//Longest string from array
		NSLog(@"The longest string is %@", [EKArrayStuff longestStringInArray:[@[@"Kiev", @"Moscow", @"Tokyo", @"Saint-Petersburg", @"SanFrancisco"] mutableCopy]]);
		
			//Shortest string from array
		NSLog(@"The shortest string is %@", [EKArrayStuff shortestStringInArray:[@[@"DRY", @"KISS", @"YAGNI", @"SOLID", @"GRASP"] mutableCopy]]);
        
            //Sieve of Eratosf
        NSLog(@"Primes from sieve %@", [[EKNumbersStuff primeNumbersFromSieveEratosthenesWithMaxNumber:42] description]);
        
            //GCD
        NSLog(@"Greatest common divisor of two numbers is %lu", (unsigned long)[EKNumbersStuff greatestCommonDivisorWithFirstNumber:42 secondNumber:84]);
        
            //LCM
        NSLog(@"Least common multiple of two numbers is %lu", [EKNumbersStuff leastCommonMultipleWithFirstNumber:16 secondNumber:20]);
        
            //Factorial
        NSLog(@"Factorial is %llu", (unsigned long long)[EKNumbersStuff factorialForNumber:3]);
        
            //Fibonacci numbers
        NSLog(@"Fibonacci series is %@", [EKNumbersStuff fibonacciNumbersUpToNumber:15]);
        
            //Stack
        EKStack *stack = [[EKStack alloc] initWithSize:3];
        [stack push:@"Hello"];
        [stack push:@"World"];
        [stack push:@"Programming is fun!"];
        NSLog(@"All from stack %@", [[stack allObjectsFromStack] debugDescription]);
        
	}
	return 0;
}


