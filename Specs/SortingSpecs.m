
#import "SpecHelpers.h"
#import "NSArray+EKSorting.h"

SPEC_BEGIN(Sorting_Specs)

describe(@"Sorting algorithms", ^{
    describe(@"Reversing array", ^{
        describe(@"CocoaImplementationOfReversedArray - Cocoa implementation", ^{
            it(@"should return reversed array for a given array", ^{
                NSUInteger N = 100;

                NSMutableArray *originalArray = [NSMutableArray array];

                for (int i = 0; i < N; i++) {
                    [originalArray addObject:@(i + 1)];
                }

                NSArray *reversedArray = [originalArray CocoaImplementationOfReversedArray];

                for (int i = 0; i < N; i++) {
                    [[[reversedArray objectAtIndex:i] should] equal:[originalArray objectAtIndex:(originalArray.count - 1 - i)]];
                }
            });
        });

        describe(@"reverse - EKAlgorithms implementation", ^{
            it(@"should return reversed array for a given array", ^{
                NSUInteger N = 100;

                NSMutableArray *originalArray = [NSMutableArray array];

                for (int i = 0; i < N; i++) {
                    [originalArray addObject:@(i + 1)];
                }

                NSMutableArray *reversedArray = [[originalArray mutableCopy] reverse];

                for (int i = 0; i < N; i++) {
                    [[[reversedArray objectAtIndex:i] should] equal:[originalArray objectAtIndex:(originalArray.count - 1 - i)]];
                }
            });
        });
    });

    describe(@"Bubble Sort", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 100;

            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }

            array = [NSMutableArray arrayWithArray:[array shuffle]];

            [array bubbleSort];

            NSArray *sortedArray = [array copy];

            [[theValue([sortedArray isSorted]) should] beYes];

            for (NSUInteger i = 0; i < N - 1; i++) {
                float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];

                [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
            }
        });
    });

    describe(@"Naive Bubble Sort", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 100;

            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }

            array = [NSMutableArray arrayWithArray:[array shuffle]];

            [array naiveBubbleSort];

            NSArray *sortedArray = [array copy];

            [[theValue([sortedArray isSorted]) should] beYes];

            for (NSUInteger i = 0; i < N - 1; i++) {
                float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];

                [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
            }
        });
    });

    describe(@"Insertion Sort", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 100;

            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }

            array = [NSMutableArray arrayWithArray:[array shuffle]];

            [array insertionSort];

            NSArray *sortedArray = [array copy];

            [[theValue([sortedArray isSorted]) should] beYes];

            for (NSUInteger i = 0; i < N - 1; i++) {
                float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];

                [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
            }
        });
    });

    describe(@"Selection Sort", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 100;

            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }

            array = [NSMutableArray arrayWithArray:[array shuffle]];

            [array selectionSort];

            NSArray *sortedArray = [array copy];

            for (NSUInteger i = 0; i < N - 1; i++) {
                float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];

                [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
            }
        });
    });

    describe(@"Partial Selection Sort", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 10, K = 5;

            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }

            array = [NSMutableArray arrayWithArray:[array shuffle]];

            [array partialSelectionSort:5];

            NSArray *sortedArray = [array copy];

            NSUInteger kthElementValue = [[sortedArray objectAtIndex:K - 1] unsignedIntegerValue];

            [[theValue(kthElementValue) should] equal:theValue(K)];

            for (NSUInteger i = 0; i < K - 1; i++) {
                NSUInteger ithElementValue = [[sortedArray objectAtIndex:i] unsignedIntegerValue];

                [[theValue(ithElementValue < kthElementValue) should] beTrue];
            }

            for (NSUInteger i = K; i < N; i++) {
                NSUInteger ithElementValue = [[sortedArray objectAtIndex:i] unsignedIntegerValue];

                [[theValue(ithElementValue > kthElementValue) should] beTrue];
            }
        });
    });

    describe(@"Quick Sort", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 100;

            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }

            array = [NSMutableArray arrayWithArray:[array shuffle]];

            [array quickSortWithLeftIndex:0 withRightIndex:(array.count - 1)];

            NSArray *sortedArray = [array copy];

            [[theValue([sortedArray isSorted]) should] beYes];

            for (NSUInteger i = 0; i < N - 1; i++) {
                float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];

                [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
            }
        });
    });

    describe(@"Heap Sort", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 100;

            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }

            array = [NSMutableArray arrayWithArray:[array shuffle]];

            [array heapSort];

            NSArray *sortedArray = [array copy];

            [[theValue([sortedArray isSorted]) should] beYes];

            for (NSUInteger i = 0; i < N - 1; i++) {
                float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];

                [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
            }
        });
    });
    
    describe(@"Radix Sort Base 10", ^{
        it(@"", ^{
            NSMutableArray *array = [NSMutableArray array];

            NSUInteger N = 100;
            
            for (int i = 0; i < N; i++) {
                [array addObject:@(i + 1)];
            }
            
            array = [NSMutableArray arrayWithArray:[array shuffle]];
            
            [array radixSortForBase:10];
            
            NSArray *sortedArray = [array copy];
            
            [[theValue([sortedArray isSorted]) should] beYes];
            
            for (NSUInteger i = 0; i < N - 1; i++) {
                float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];
                
                [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
            }
        });
    });
    
});

SPEC_END

