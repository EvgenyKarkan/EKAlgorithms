//
//  NSArray+EKStuff.m
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSArray+EKStuff.h"

@implementation NSArray (EKStuff);

#pragma mark - ARRAY STUFF
#pragma mark - Max element in array

- (NSUInteger)indexOfMaximumElement
{
    NSInteger maximumValue = [[self objectAtIndex:0] integerValue];
    NSUInteger indexOfMaximumValue = 0;

    NSUInteger count = [self count];

    for (NSUInteger i = 1; i < count; i++) {
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
    NSUInteger count = self.count;

    if (count == 0) return nil;
    
    NSInteger minimalValue = NSIntegerMax;
    NSInteger maximalValue = NSIntegerMin;
    
    NSUInteger minimalValueIndex = 0;
    NSUInteger maximalValueIndex = 0;

    // Machine way of doing odd/even check is better than mathematical count % 2
    BOOL oddnessFlag = count & 1;
    
    if (oddnessFlag) {
        minimalValue = maximalValue = [self.lastObject integerValue];
        minimalValueIndex = maximalValueIndex = count - 1;
    }

    NSUInteger idx = 0;
    NSInteger values[2];

    for (NSNumber *number in self) {
        if (((idx++) & 1) == 0) {
            values[0] = [number integerValue];

            continue;
        } else {
            values[1] = [number integerValue];
        }

        NSInteger iValue = values[0];
        NSInteger ip1Value = values[1];

        NSUInteger iidx = idx - 2;
        NSUInteger ip1idx = idx - 1;

        if (iValue < ip1Value) {
            if (minimalValue > iValue) {
                minimalValue = iValue;
                minimalValueIndex = iidx;
            }
            
            if (maximalValue < ip1Value) {
                maximalValue = ip1Value;
                maximalValueIndex = ip1idx;
            }
        }
        else if (iValue > ip1Value) {
            if (minimalValue > ip1Value) {
                minimalValue = ip1Value;
                minimalValueIndex = ip1idx;
            }
            
            if (maximalValue < iValue) {
                maximalValue = iValue;
                maximalValueIndex = iidx;
            }
        }
        else {
            if (minimalValue > iValue) {
                minimalValue = iValue;
                minimalValueIndex = iidx;
            }
            
            if (maximalValue < iValue) {
                maximalValue = iValue;
                maximalValueIndex = iidx;
            }
        }
    }
    
    return @[@(minimalValueIndex), @(maximalValueIndex)];
}

#pragma mark - Longest string in array

- (NSString *)longestString
{
    NSString *returnValue = nil;
    
    for (NSString *string in self) {
        if (returnValue == nil || ([string length] > [returnValue length])) {
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
        if (returnValue == nil || ([string length] < [returnValue length])) {
            returnValue = string;
        }
    }
    
    return returnValue;
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
    NSMutableDictionary *registry = [[NSMutableDictionary alloc] initWithCapacity:self.count];

    for (id element in self) {
        if (registry[element] == nil) {
            registry[element] = @(YES);
        } else {
            return YES;
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

#pragma mark - Sum of elements

- (NSNumber *)sumOfElements
{
    NSUInteger count = [self count];

    long long int sum = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        sum = sum + [self[i] longLongValue];
    }
    
    return @(sum);
}

#pragma mark - Occurrences of each element in array

- (NSDictionary *)occurencesOfEachElementInArray_naive
{
    NSUInteger count = [self count];

    NSMutableDictionary *registry = [NSMutableDictionary dictionaryWithCapacity:count];

    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger counter = 0;

        for (NSUInteger j = 0; j < count; j++) {
            if ([self[i] isEqual:self[j]]) {
                counter++;
            }
        }

        [registry setObject:@(counter)
                   forKey:self[i]];
    }
    
    return registry;
}

- (NSDictionary *)occurencesOfEachElementInArray
{
    NSUInteger count = [self count];

    NSMutableDictionary *registry = [NSMutableDictionary dictionaryWithCapacity:count];

    for (NSUInteger i = 0; i < count; i++) {
        id currentElement = self[i];

        NSNumber *existingElementCounter = registry[currentElement];
        
        NSUInteger currentCount = existingElementCounter ? existingElementCounter.unsignedIntegerValue : 0;
        
        currentCount++;
        
        registry[currentElement] = @(currentCount);
    }
    
    return registry;
}

- (NSDictionary *)CocoaImplementationOfOccurencesOfEachElementInArray
{
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:self];
    NSMutableDictionary *dictionary = [@{} mutableCopy];
    
    for (id object in [countedSet allObjects]) {
        [dictionary setObject:@([countedSet countForObject:object])
                       forKey:object];
    }
    
    return dictionary;
}

#pragma mark - SEARCH STUFF
#pragma mark - Linear search

- (NSInteger)indexOfObjectViaLinearSearch:(id)object
{
    NSUInteger count = [self count];

    for (int i = 0; i < count; i++) {
        if ([object isEqual:[self objectAtIndex:i]]) {
            return i;
        }
    }

    return NSNotFound;
}

#pragma mark - Binary search

- (NSInteger)indexOfObjectViaBinarySearch:(id)object
{
    NSUInteger firstIndex = 0;
    NSUInteger uptoIndex = [self count];

    while (firstIndex < uptoIndex) {
        NSUInteger mid = (firstIndex + uptoIndex) / 2;

        if ([object integerValue] < [[self objectAtIndex:mid] integerValue]) {
            uptoIndex = mid;
        }
        else if ([object integerValue] > [[self objectAtIndex:mid] integerValue]) {
            firstIndex = mid + 1;
        }
        else {
            return mid;
        }
    }
    
    return NSNotFound;
}


@end
