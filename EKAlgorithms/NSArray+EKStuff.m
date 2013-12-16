//
//  NSArray+EKStuff.m
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSArray+EKStuff.h"
#import "NSMutableArray+EKStuff.h"

@implementation NSArray (EKStuff);

#pragma mark - ARRAY STUFF
#pragma mark - Max element in array

- (NSUInteger)indexOfMaximumElement
{
	NSInteger maximumValue = [[self objectAtIndex:0] integerValue];
	NSUInteger indexOfMaximumValue = 0;
    
	for (NSUInteger i = 1; i < [self count]; i++) {
		NSInteger value = [[self objectAtIndex:i] integerValue];
        
		if (value > maximumValue) {
			maximumValue = value;
			indexOfMaximumValue = i;
		}
	}
    
	return indexOfMaximumValue;
}

- (NSArray *)indexesOfMinimumAndMaximumElements
{
    if (self.count == 0) return nil;

    NSInteger minimalValue = NSIntegerMax,
              maximalValue = NSIntegerMin;

    NSUInteger minimalValueIndex,
               maximalValueIndex;

    NSUInteger count = self.count;

    BOOL oddnessFlag = count % 2;

    if (oddnessFlag) {
        minimalValue = maximalValue = [self.firstObject integerValue];
        minimalValueIndex = maximalValueIndex = 0;
    }

	for (NSUInteger i = oddnessFlag; i < count; i = i + 2) {
        NSInteger iValue = [[self objectAtIndex:i] integerValue];
        NSInteger ip1Value = [[self objectAtIndex:i + 1] integerValue];

        if (iValue < ip1Value) {
            if (minimalValue > iValue) {
                minimalValue = iValue;
                minimalValueIndex = i;
            }

            if (maximalValue < ip1Value) {
                maximalValue = ip1Value;
                maximalValueIndex = i + 1;
            }
        } else if (iValue > ip1Value) {
            if (minimalValue > ip1Value) {
                minimalValue = ip1Value;
                minimalValueIndex = i + 1;
            }

            if (maximalValue < iValue) {
                maximalValue = iValue;
                maximalValueIndex = i;
            }
        } else {
            if (minimalValue > iValue) {
                minimalValue = iValue;
                minimalValueIndex = i;
            }

            if (maximalValue < iValue) {
                maximalValue = iValue;
                maximalValueIndex = i;
            }
        }
	}

    return @[ @(minimalValueIndex), @(maximalValueIndex) ];
}

#pragma mark - Longest string in array

- (NSString *)longestString
{
	NSString *returnValue = nil;
    
	for (NSString *string in self) {
		if (returnValue == nil || [string length] > [returnValue length]) {
			returnValue = string;
		}
	}
    
	return returnValue;
}

#pragma mark - Shortest string in array

- (NSString *)shortestString
{
    NSString *returnValue = nil;
    
	for (NSString *string in self) {
		if (returnValue == nil || [string length] < [returnValue length]) {
			returnValue = string;
		}
	}
    
	return returnValue;
}

#pragma mark - Array reverse

- (NSArray *)reversedArray
{
    NSMutableArray *reversedArray = [self mutableCopy];

    NSUInteger count = reversedArray.count;

    for (int i = 0; i < count / 2; i++) {
        [reversedArray exchangeObjectAtIndex:i withObjectAtIndex:(count - 1 - i)];
    }

    return [reversedArray copy];
}

- (NSArray *)CocoaImplementationOfReversedArray
{
    return [[self reverseObjectEnumerator] allObjects];
}

#pragma mark - Intersection of two arrays

- (NSArray *)intersectionWithArray:(NSArray *)secondArray
{
	NSMutableSet *intersection = [NSMutableSet setWithArray:self];
	[intersection intersectSet:[NSSet setWithArray:secondArray]];
    
	return [intersection allObjects];
}

#pragma mark - Union of two arrays

- (NSArray *)unionWithoutDuplicatesWithArray:(NSArray *)secondArray
{
	NSSet *firstSet = [NSSet setWithArray:self];
	NSSet *secondSet = [NSSet setWithArray:secondArray];
    
	NSMutableSet *resultSet = [NSMutableSet setWithSet:firstSet];
	[resultSet unionSet:secondSet];
    
	return [resultSet allObjects];
}

#pragma mark - Find duplicates

- (BOOL)hasDuplicates
{
	for (NSUInteger i = 0; i < [self count]; i++) {
		for (NSUInteger j = i + 1; j < [self count]; j++) {
			if (i != j && [self[i] isEqualTo:self[j]]) {
				return YES;
			}
		}
	}
    
	return NO;
}

#pragma mark - Array with random NSNumber objects

+ (NSArray *)randomObjectsWithArraySize:(NSUInteger)arraySize maxRandomValue:(NSUInteger)maxValue uniqueObjects:(BOOL)unique
{
	NSAssert(maxValue >= arraySize, @"Max random value should not be less than array size");
    
	NSMutableArray *objects = [@[] mutableCopy];
	NSUInteger randomObject = 0;
    
	while ([objects count] < arraySize) {
		randomObject = arc4random() % maxValue;
		if (unique && ![objects containsObject:[NSNumber numberWithUnsignedInteger:randomObject]]) {
			[objects addObject:[NSNumber numberWithUnsignedInteger:randomObject]];
		}
		if (!unique) {
			[objects addObject:[NSNumber numberWithUnsignedInteger:randomObject]];
		}
	}
    
	return [objects copy];
}

#pragma mark - Check if array is sorted

- (BOOL)isSorted
{
	for (NSUInteger i = 0; i < [self count] - 1; i++) {
		if ([self[i] isKindOfClass:[NSNumber class]]) {
			if ([self[i] floatValue] > [self[i + 1] floatValue]) {
				return NO;
			}
		}
		else {
			NSException *exception = [NSException exceptionWithName:@"NSNumber not found" reason:@"Method can check is array sorted with NSNumber members only" userInfo:nil];
			[exception raise];
		}
	}
	return YES;
}

#pragma mark - Sum of elements

- (NSNumber *)sumOfElements
{
    long long int sum = 0;
    
    for (NSUInteger i = 0; i < [self count]; i++) {
        sum = sum + [self[i] longLongValue];
    }
    
    return @(sum);
}

#pragma mark - Array shuffle

- (NSArray *)shuffledArray
{
	NSUInteger i = self.count;
	NSMutableArray *shuffledArray = [self mutableCopy];
    
	while (i) {
		NSUInteger randomIndex = arc4random_uniform((u_int32_t)i);
		[shuffledArray exchangeObjectAtIndex:randomIndex withObjectAtIndex:--i];
	}
    
	return [shuffledArray copy];
}

#pragma mark - SEARCH STUFF
#pragma mark - Linear search

- (NSInteger)indexOfObjectViaLinearSearch:(id)object
{
	NSInteger i = 0, indexOfFoundedObject = 0;
    
	for (i = 0; i < [self count]; i++) {
		if (object == [self objectAtIndex:i]) {
			indexOfFoundedObject = i;
			break;
		}
	}
	if (i == [self count]) {
		indexOfFoundedObject = -1;
	}
    
	return indexOfFoundedObject;
}

#pragma mark - Binary search

- (NSInteger)indexOfObjectViaBinarySearch:(id)object
{
	NSUInteger firstIndex = 0;
	NSUInteger uptoIndex = [self count];
	NSUInteger indexOfFoundedObject = 0;
    
	while (firstIndex < uptoIndex) {
		NSUInteger mid = (firstIndex + uptoIndex) / 2;
		if ([object isKindOfClass:[NSNumber class]]) {
			if ([object integerValue] < [[self objectAtIndex:mid] integerValue]) {
				uptoIndex = mid;
			}
			else if ([object integerValue] > [[self objectAtIndex:mid] integerValue]) {
				firstIndex = mid + 1;
			}
			else {
				return indexOfFoundedObject = mid;
			}
		}
	}
    
	return indexOfFoundedObject = -1;
}

#pragma mark - SORT STUFF
#pragma mark - Bubble sort

- (NSMutableArray *)bubbleSortedArray
{
	NSMutableArray *selfCopy = [self mutableCopy];
	id temp = nil;
    
	for (int i = (int)[selfCopy count] - 2; i >= 0; i--) {
		for (int j = 0; j <= i; j++) {
			if ([selfCopy[j] integerValue] > [selfCopy[j + 1] integerValue]) {
				temp = [selfCopy objectAtIndex:j];
				[selfCopy replaceObjectAtIndex:j withObject:[selfCopy objectAtIndex:j + 1]];
				[selfCopy replaceObjectAtIndex:j + 1 withObject:temp];
			}
		}
	}
    
	return selfCopy;
}

#pragma mark - Shell sort

- (NSMutableArray *)shellSortedArray
{
	NSMutableArray *selfCopy = [self mutableCopy];
	id temp = nil;
    
	for (NSInteger i = [selfCopy count] / 2; i > 0; i = i / 2) {
		for (NSInteger j = i; j < [selfCopy count]; j++) {
			for (NSInteger k = j - i; k >= 0; k = k - i) {
				if ([[selfCopy objectAtIndex:k + 1] floatValue] >= [[selfCopy objectAtIndex:k] floatValue]) {
					break;
				}
				else {
					temp = [selfCopy objectAtIndex:k];
					[selfCopy replaceObjectAtIndex:k withObject:[selfCopy objectAtIndex:k + i]];
					[selfCopy replaceObjectAtIndex:k + i withObject:temp];
				}
			}
		}
	}
    
	return selfCopy;
}

#pragma mark - Merge sort stuff

- (NSMutableArray *)mergeSortedArray
{
	NSMutableArray *selfCopy = [self mutableCopy];
	[selfCopy partitionArrayWithMinimalIndex:0 withMaximumIndex:(NSInteger)[selfCopy count] - 1];
    
	return selfCopy;
}

#pragma mark - Quick sort

- (NSMutableArray *)quickSortedArrayWithLeftIndex:(NSInteger)left withRightIndex:(NSInteger)right
{
	NSMutableArray *selfCopy = (NSMutableArray *)self;
    
	if (![self isKindOfClass:[NSMutableArray class]]) {
		selfCopy = [self mutableCopy];
	}
    
	NSInteger i = 0, j = 0;
	id x = nil, y = nil;
    
	i = left;
	j = right;
	x = selfCopy[(left + right) / 2];
    
	do {
		while (([selfCopy[i] floatValue] < [x floatValue]) && (i < right)) {
			i++;
		}
		while (([x floatValue] < [selfCopy[j] floatValue]) && (j > left)) {
			j--;
		}
        
		if (i <= j) {
			y = selfCopy[i];
			[selfCopy replaceObjectAtIndex:i withObject:selfCopy[j]];
			selfCopy[j] = y;
			i++;
			j--;
		}
	}
	while (i <= j);
    
	if (left < j) {
		selfCopy = [selfCopy quickSortedArrayWithLeftIndex:left withRightIndex:j];
	}
	if (i < right) {
		selfCopy = [selfCopy quickSortedArrayWithLeftIndex:i withRightIndex:right];
	}
    
	return selfCopy;
}

#pragma mark - Insertion sort

- (NSMutableArray *)insertionSortedArray
{
	NSMutableArray *selfCopy = [self mutableCopy];
	NSInteger a = 0, b = 0;
    
	id temp = nil;
    
	for (a = 1; a < (NSInteger)[selfCopy count]; ++a) {
		temp = selfCopy[a];
		for (b = a - 1; (b >= 0) && ([temp floatValue] < [selfCopy[b] floatValue]); b--) {
			[selfCopy replaceObjectAtIndex:b + 1 withObject:selfCopy[b]];
		}
		selfCopy[b + 1] = temp;
	}
    
	return selfCopy;
}

#pragma mark - Selection sort

- (NSMutableArray *)selectionSortedArray
{
	NSMutableArray *selfCopy = [self mutableCopy];
    
	for (NSUInteger i = 0; i < [selfCopy count] - 1; i++) {
		NSUInteger min = i;
		for (NSUInteger j = i + 1; j < [selfCopy count]; j++) {
			if ([selfCopy[j] floatValue]  < [selfCopy[min] floatValue]) {
				min = j;
			}
		}
        
		id tempObject = selfCopy[i];
		selfCopy[i] = selfCopy[min];
		selfCopy[min] = tempObject;
	}
    
	return selfCopy;
}

#pragma mark - Heap sort

- (NSMutableArray *)heapSortedArray
{
	NSMutableArray *selfCopy = [self mutableCopy];
	[selfCopy heapifyArrayWithSize:[selfCopy count]];
    
	NSInteger end = [selfCopy count] - 1;
    
	while (end > 0) {
		[selfCopy exchangeObjectAtIndex:end withObjectAtIndex:0];
		[selfCopy siftDownArrayWithStart:0 end:end - 1];
		end--;
	}
    
	return selfCopy;
}

@end
