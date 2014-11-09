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
    id maximumValue = [self firstObject];

    NSUInteger indexOfMaximumValue = 0;

    NSUInteger count = [self count];

    for (NSUInteger i = 1; i < count; i++) {
        id value = self[i];
        
        if ([value compare:maximumValue] == NSOrderedDescending) {
            maximumValue        = value;
            indexOfMaximumValue = i;
        }
    }
    
    return indexOfMaximumValue;
}

- (NSArray *)indexesOfMinimumAndMaximumElements
{
    NSUInteger count = self.count;

    if (count == 0) return nil;
    
    NSNumber  *minimalValue = @(NSIntegerMax);
    NSNumber  *maximalValue = @(NSIntegerMin);
    
    NSUInteger minimalValueIndex = 0;
    NSUInteger maximalValueIndex = 0;

    // Machine way of doing odd/even check is better than mathematical count % 2
    BOOL oddnessFlag = count & 1;
    
    if (oddnessFlag) {
        minimalValue      = maximalValue      = self.lastObject;
        minimalValueIndex = maximalValueIndex = count - 1;
    }

    NSUInteger idx = 0;
    NSNumber *values[2];

    for (NSNumber *number in self) {
        if (((idx++) & 1) == 0) {
            values[0] = number;
            
            continue;
        }
        else {
            values[1] = number;
        }
        
        NSNumber *iValue   = values[0];
        NSNumber *ip1Value = values[1];
        
        NSUInteger iidx   = idx - 2;
        NSUInteger ip1idx = idx - 1;
        
        if ([iValue compare:ip1Value] == NSOrderedAscending) {
            if ([minimalValue compare:iValue] == NSOrderedDescending) {
                minimalValue      = iValue;
                minimalValueIndex = iidx;
            }
            
            if ([maximalValue compare:ip1Value] == NSOrderedAscending) {
                maximalValue      = ip1Value;
                maximalValueIndex = ip1idx;
            }
        }
        else if ([iValue compare:ip1Value] == NSOrderedDescending) {
            if ([minimalValue compare:ip1Value] == NSOrderedDescending) {
                minimalValue      = ip1Value;
                minimalValueIndex = ip1idx;
            }
            
            if ([maximalValue compare:iValue] == NSOrderedAscending) {
                maximalValue      = iValue;
                maximalValueIndex = iidx;
            }
        }
        else {
            if ([minimalValue compare:iValue] == NSOrderedDescending) {
                minimalValue      = iValue;
                minimalValueIndex = iidx;
            }
            
            if ([maximalValue compare:iValue] == NSOrderedAscending) {
                maximalValue      = iValue;
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
    NSSet *firstSet  = [NSSet setWithArray:self];
    NSSet *secondSet = [NSSet setWithArray:secondArray];
    
    NSMutableSet *resultSet = [NSMutableSet setWithSet:firstSet];
    [resultSet unionSet:secondSet];
    
    return [resultSet allObjects];
}

- (NSArray *)unionWithoutDuplicatesWithArray:(NSArray *)secondArray forKey:(NSString *)currentKey
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
    [mutableArray addObjectsFromArray:secondArray];
    
    NSArray *copy = [mutableArray copy];
    NSUInteger index = [copy count] - 1;
    
    for (id object in [copy reverseObjectEnumerator]) {
        
        for (NSUInteger i = 0; i < index; i++) {
            if ([[mutableArray[i] valueForKey:currentKey] isEqualToString:[object valueForKey:currentKey]]){
                [mutableArray removeObjectAtIndex:index];
                break;
            }
        }
        index --;
    }
    
    return mutableArray;
}

#pragma mark - Find duplicates

- (BOOL)hasDuplicates
{
    NSMutableDictionary *registry = [[NSMutableDictionary alloc] initWithCapacity:self.count];

    for (id element in self) {
        NSNumber *elementHash = @([element hash]);
        
        if (registry[elementHash] == nil) {
            registry[elementHash] = element;
        }
        else {
            NSLog(@"-[NSArray hasDuplicates] found duplicate elements: %@ and %@", registry[elementHash], element);
            
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
        if (unique && ![objects containsObject:@(randomObject)]) {
            [objects addObject:@(randomObject)];
        }
        if (!unique) {
            [objects addObject:@(randomObject)];
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
        
        registry[self[i]] = @(counter);
    }
    
    return registry;
}

- (NSDictionary *)occurencesOfEachElementInArray
{
    NSUInteger count              = [self count];
    NSMutableDictionary *registry = [NSMutableDictionary dictionaryWithCapacity:count];
    
    for (NSUInteger i = 0; i < count; i++) {
        
        id currentElement                = self[i];
        NSNumber *existingElementCounter = registry[currentElement];
        NSUInteger currentCount          = existingElementCounter ? existingElementCounter.unsignedIntegerValue : 0;
        
        currentCount++;
        
        registry[currentElement] = @(currentCount);
    }
    
    return registry;
}

- (NSDictionary *)CocoaImplementationOfOccurencesOfEachElementInArray
{
    NSCountedSet *countedSet        = [[NSCountedSet alloc] initWithArray:self];
    NSMutableDictionary *dictionary = [@{} mutableCopy];
    
    NSArray* setAllObjects = [countedSet allObjects];
    
    for (id object in setAllObjects) {
        dictionary[object] = @([countedSet countForObject:object]);
    }
    
    return dictionary;
}

#pragma mark - SEARCH STUFF
#pragma mark - Linear search

- (NSInteger)indexOfObjectViaLinearSearch:(id)object
{
    NSUInteger count = [self count];

    for (NSUInteger i = 0; i < count; i++) {
        if ([object isEqual:self[i]]) {
            return i;
        }
    }

    return NSNotFound;
}

#pragma mark - Binary search

- (NSInteger)indexOfObjectViaBinarySearch:(id)object
{
    NSUInteger firstIndex = 0;
    NSUInteger uptoIndex  = [self count];

    while (firstIndex < uptoIndex) {
        NSUInteger mid = (firstIndex + uptoIndex) / 2;

        if ([object compare:self[mid]] == NSOrderedAscending) {
            uptoIndex = mid;
        }
        else if ([object compare:self[mid]] == NSOrderedDescending) {
            firstIndex = mid + 1;
        }
        else {
            return mid;
        }
    }
    
    return NSNotFound;
}

@end
