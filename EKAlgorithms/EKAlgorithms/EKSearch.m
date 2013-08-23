//
//  EKSearch.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKSearch.h"


@implementation EKSearch;

#pragma mark - Linear search

+ (NSInteger)indexOfObjectViaLinearSearchForObject:(id)object inArray:(NSArray *)arrayToSearch
{
	NSInteger i, indexOfFoundedObject = 0;
	
	for (i = 0; i < [arrayToSearch count]; i++) {
		if (object == [arrayToSearch objectAtIndex:i]) {
			indexOfFoundedObject = i;
			break;
		}
	}
	if (i == [arrayToSearch count]) {
		indexOfFoundedObject = -1;
	}
	
	return indexOfFoundedObject;
}

#pragma mark - Binary search

+ (NSInteger)inedxOfObjectViaBinarySearchForObject:(id)object inSortedArray:(NSArray *)sortedArray
{
	NSUInteger firstIndex = 0;
	NSUInteger uptoIndex = [sortedArray count];
	NSUInteger indexOfFoundedObject = 0;
	
	while (firstIndex < uptoIndex) {
		NSUInteger mid = (firstIndex + uptoIndex) / 2;
		if ([object isKindOfClass:[NSNumber class]]) {
			if ([object integerValue] < [[sortedArray objectAtIndex:mid] integerValue]) {
				uptoIndex = mid;
			}
			else if ([object integerValue] > [[sortedArray objectAtIndex:mid] integerValue]) {
				firstIndex = mid + 1;
			}
			else {
				return indexOfFoundedObject = mid;
			}
		}
	}
	
	return indexOfFoundedObject = -1;
}

@end
