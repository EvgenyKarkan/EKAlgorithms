//
//  NSArray+EKSorting.m
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 31/03/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "NSArray+EKSorting.h"
#import "SSRadixNode.h"


@implementation NSArray (EKSorting)

#pragma mark - Check if array is sorted

- (BOOL)isSorted
{
    NSUInteger countMinusOne = self.count - 1;

    for (NSUInteger i = 0; i < countMinusOne; i++) {
        if ([self[i] compare:self[i + 1]] == NSOrderedDescending) {
            return NO;
        }
    }

    return YES;
}

- (NSArray *)CocoaImplementationOfReversedArray
{
    return [[self reverseObjectEnumerator] allObjects];
}

@end


@implementation NSMutableArray (EKSorting)

#pragma mark - Array reverse

- (NSMutableArray *)reverse
{
    NSUInteger count = self.count;

    for (int i = 0; i < count / 2; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - 1 - i)];
    }

    return self;
}

#pragma mark - Array shuffle

- (NSMutableArray *)shuffle
{
    NSUInteger i = self.count;

    while (i) {
        NSUInteger randomIndex = arc4random_uniform((u_int32_t)i);
        [self exchangeObjectAtIndex:randomIndex withObjectAtIndex:--i];
    }

    return self;
}

#pragma mark - Bubble sort

- (NSMutableArray *)naiveBubbleSort
{
    NSUInteger count = [self count];

    for (int i = 0; i < count; i++) {
        for (int j = 0; j < (count - 1); j++) {
            if ([self[j] compare:self[j + 1]] == NSOrderedDescending) {
                [self exchangeObjectAtIndex:j withObjectAtIndex:(j + 1)];
            }
        }
    }

    return self;
}

- (NSMutableArray *)bubbleSort
{
    NSUInteger count = [self count];
    
    for (int i = ((int)count - 2); i >= 0; i--) {
        for (int j = 0; j <= i; j++) {
            if ([self[j] compare:self[j + 1]] == NSOrderedDescending) {
                [self exchangeObjectAtIndex:j withObjectAtIndex:(j + 1)];
            }
        }
    }
    
    return self;
}

#pragma mark - Shell sort

- (NSMutableArray *)shellSort
{
    NSUInteger count = [self count];

    for (NSInteger i = count / 2; i > 0; i = i / 2) {
        for (NSInteger j = i; j < count; j++) {
            for (NSInteger k = j - i; k >= 0; k = k - i) {
                if ([self[k + 1] floatValue] >= [self[k] floatValue]) {
                    break;
                }
                else {
                    [self exchangeObjectAtIndex:k withObjectAtIndex:(k + i)];
                }
            }
        }
    }

    return self;
}

#pragma mark - Merge sort stuff

- (NSMutableArray *)mergeSort
{
    NSUInteger count = [self count];
    
    [self partitionArrayWithMinimalIndex:0 withMaximumIndex:(count - 1)];
    
    return self;
}

#pragma mark - Quick sort

- (NSMutableArray *)quickSortWithLeftIndex:(NSInteger)left withRightIndex:(NSInteger)right
{
    NSInteger i = left;
    NSInteger j = right;
    
    id pivotalElement = nil;
    
    pivotalElement = self[(left + right) / 2];
    
    do {
        while (([self[i] floatValue] < [pivotalElement floatValue]) && (i < right)) {
            i++;
        }
        while (([pivotalElement floatValue] < [self[j] floatValue]) && (j > left)) {
            j--;
        }
        
        if (i <= j) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:j];
            
            i++;
            j--;
        }
    }
    while (i <= j);
    
    if (left < j) {
        [self quickSortWithLeftIndex:left withRightIndex:j];
    }
    
    if (i < right) {
        [self quickSortWithLeftIndex:i withRightIndex:right];
    }
    
    return self;
}

#pragma mark - Insertion sort

- (NSMutableArray *)insertionSort
{
    NSUInteger count = self.count;

    for (int i = 1; i < count; i++) {
        for (int j = i; (j > 0) && ([self[j - 1] floatValue] > [self[j] floatValue]); j--) {
            [self exchangeObjectAtIndex:j withObjectAtIndex:(j - 1)];
        }
    }

    return self;
}

#pragma mark - Selection sort

- (NSMutableArray *)selectionSort
{
    NSUInteger count = self.count;

    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger min = i;

        for (NSUInteger j = i + 1; j < count; j++) {
            if ([self[j] floatValue]  < [self[min] floatValue]) {
                min = j;
            }
        }

        [self exchangeObjectAtIndex:i withObjectAtIndex:min];
    }

    return self;
}

#pragma mark - Radix Sort

- (NSMutableArray *)radixSortForBase:(NSInteger)base
{
    int max = [[self valueForKeyPath:@"@max.intValue"] intValue];

    int numberOfSteps = (log(max) / log(base)) + 1;

    for (int i = 0; i < numberOfSteps; i++) {
        NSMutableArray *radixTable = [NSMutableArray makeRadixTableForArray:self forBase:base forDigit:i];

        [self setArray:[NSMutableArray makeArrayFromRadixTable:radixTable]];
    }

    return self;
}

+ (NSMutableArray *)makeArrayFromRadixTable:(NSMutableArray *)radixTable
{
    NSMutableArray *theArray = [NSMutableArray new];
    
    for (SSRadixNode *bucketNode in radixTable) {
        SSRadixNode *bucket = bucketNode.next;
        while (bucket) {
            [theArray addObject:@(bucket.data)];
            bucket = bucket.next;
        }
    }
    return theArray;
}

+ (NSMutableArray *)makeRadixTableForArray:(NSMutableArray *)theArray forBase:(NSInteger)base forDigit:(NSInteger)digit
{
    NSMutableArray *radixTable = [self getTableOfEmptyBucketsForSize:base];
    
    for (int i = 0; i < theArray.count; i++) {
        NSInteger value = [theArray[i] integerValue];
        NSInteger radixIndex = [self getExaminedNumber:value withBase:base atDigit:digit];
        SSRadixNode *current = (SSRadixNode *)radixTable[radixIndex];
        if (current.next) {
            while (current.next) {
                current = [current next];
            }
        }
        SSRadixNode *newEntry = [SSRadixNode new];
        newEntry.data = [theArray[i] intValue];
        current.next = newEntry;
    }
    
    return radixTable;
}

+ (NSMutableArray *)getTableOfEmptyBucketsForSize:(NSInteger)size
{
    NSMutableArray *empty = [NSMutableArray new];
    
    for (NSInteger i = 0; i < size; i++) {
        [empty addObject:[SSRadixNode new]];
    }
    
    return empty;
}

+ (NSInteger)getExaminedNumber:(NSInteger)number withBase:(NSInteger)base atDigit:(NSInteger)digit
{
    NSInteger divisor = (digit == 0) ? 1 : (pow(base, digit));
    return (number / divisor) % base;
}

#pragma mark - Partial Selection Sort

- (NSMutableArray *)partialSelectionSort:(NSUInteger)K
{
    NSUInteger count = self.count;
    NSParameterAssert(K <= count);
    
    NSUInteger minIndex;
    NSUInteger minValue;
    
    for (NSUInteger i = 0; i < K; i++) {
        minIndex = i;
        minValue = [self[i] unsignedIntegerValue];
        
        for (NSUInteger j = i + 1; j < count; j++) {
            NSUInteger el = [self[j] unsignedIntegerValue];
            
            if (el < minValue) {
                minIndex = j;
                minValue = el;
            }
        }
        
        [self exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    
    return self;
}

#pragma mark - Heap sort

- (NSMutableArray *)heapSort
{
    NSUInteger count = self.count;

    [self heapifyArrayWithSize:count];

    NSInteger end = count - 1;

    while (end > 0) {
        [self exchangeObjectAtIndex:end withObjectAtIndex:0];
        [self siftDownArrayWithStart:0 end:end - 1];
        end--;
    }
    
    return self;
}

@end



@implementation NSMutableArray (EKSortingHelpers);

#pragma mark - Used in merge sort

- (void)partitionArrayWithMinimalIndex:(NSInteger)min withMaximumIndex:(NSInteger)max
{
    NSInteger mid = 0;
    
    if (min < max) {
        mid = (min + max) / 2;
        [self partitionArrayWithMinimalIndex:min withMaximumIndex:mid];
        [self partitionArrayWithMinimalIndex:mid + 1 withMaximumIndex:max];
        [self mergeArrayWithMinimalIndex:min withMediumIndex:mid withMaximalIndex:max];
    }
}

- (void)mergeArrayWithMinimalIndex:(NSInteger)min withMediumIndex:(NSInteger)mid withMaximalIndex:(NSInteger)max
{
    NSMutableArray *temporaryArray = [NSMutableArray array];

    NSUInteger count = [self count];

    for (NSInteger i = 0; i < count; i++) {
        [temporaryArray addObject:[NSNull null]];
    }

    NSInteger i = 0, j = 0, k = 0, m = 0;
    j = min;
    m = mid + 1;

    for (i = min; j <= mid && m <= max; i++) {
        if ([self[j] floatValue] <= [self[m] floatValue]) {
            temporaryArray[i] = self[j];
            j++;
        }
        else {
            temporaryArray[i] = self[m];
            m++;
        }
    }
    if (j > mid) {
        for (k = m; k <= max; k++) {
            temporaryArray[i] = self[k];
            i++;
        }
    }
    else {
        for (k = j; k <= mid; k++) {
            temporaryArray[i] = self[k];
            i++;
        }
    }
    for (k = min; k <= max; k++) {
        self[k] = temporaryArray[k];
    }
}

#pragma mark - Used in heap sort

- (void)siftDownArrayWithStart:(NSInteger)startIndex end:(NSInteger)endIndex
{
    NSInteger root = startIndex;

    while ((root * 2 + 1) <= endIndex) {
        NSInteger child = root * 2 + 1;

        if (child + 1 <= endIndex && [self[child] floatValue] < [self[child + 1] floatValue]) {
            child++;
        }

        if ([self[root] floatValue] < [self[child] floatValue]) {
            [self exchangeObjectAtIndex:root withObjectAtIndex:child];
            root = child;
        }
        else {
            return;
        }
    }
}

- (void)heapifyArrayWithSize:(NSInteger)size
{
    NSInteger start = (size - 2) / 2;
    
    while (start >= 0) {
        [self siftDownArrayWithStart:start end:size - 1];
        start--;
    }
}

@end
