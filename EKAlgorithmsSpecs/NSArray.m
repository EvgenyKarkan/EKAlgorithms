#import <Kiwi/Kiwi.h>

#import "NSArray+EKStuff.h"

SPEC_BEGIN(NSArray_Specs)

describe(@"NSArray-based algorithms", ^{
    describe(@"Sorting algorithms", ^{
        describe(@"Selection sort", ^{
            it(@"", ^{
                NSMutableArray *array = [NSMutableArray array];

                NSUInteger N = 100;

                for (int i = 0; i < N; i++) {
                    [array addObject:@(i + 1)];
                }

                array = [NSMutableArray arrayWithArray:[array shuffledArray]];

                NSArray *sortedArray = [array selectionSortedArray];

                for (NSUInteger i = 0; i < N - 1; i++) {
                    float ithElementValue = [[sortedArray objectAtIndex:i] floatValue];
                    float iplus1thElementValue = [[sortedArray objectAtIndex:i + 1] floatValue];

                    [[theValue(ithElementValue < iplus1thElementValue) should] beTrue];
                }
            });
        });

        describe(@"Partial selection sort", ^{
            it(@"", ^{
                NSMutableArray *array = [NSMutableArray array];

                NSUInteger N = 10, K = 5;

                for (int i = 0; i < N; i++) {
                    [array addObject:@(i + 1)];
                }

                array = [NSMutableArray arrayWithArray:[array shuffledArray]];

                NSArray *sortedArray = [array partialSelectionSortedArray:5];

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
    });

    describe(@"Search algorithms", ^{
        describe(@"indexOfMaximumElement", ^{
            it(@"should return index of maximum element in array", ^{
                {
                    NSArray *array = @[ @(1), @(14), @(-30), @(1000), @(567) ];

                    NSUInteger indexOfMaximumElement = [array indexOfMaximumElement];

                    [[theValue(indexOfMaximumElement) should] equal:@(3)];
                }

                {
                    NSArray *array = @[ @(5), @(4), @(3), @(2), @(1) ];

                    NSUInteger indexOfMaximumElement = [array indexOfMaximumElement];

                    [[theValue(indexOfMaximumElement) should] equal:@(0)];
                }
            });
        });

        describe(@"indexesOfMinimumAndMaximumElements", ^{
            it(@"should return array with two elements: index of minimum element and index of maximum element", ^{
                NSArray *array = @[ @(1), @(14), @(-30), @(1000), @(567) ];

                NSArray *arrayWithIndexesOfMinimumAndMaximumElements = [array indexesOfMinimumAndMaximumElements];

                NSNumber *indexOfMinimumElement = arrayWithIndexesOfMinimumAndMaximumElements.firstObject;
                NSNumber *indexOfMaximumElement = arrayWithIndexesOfMinimumAndMaximumElements.lastObject;

                [[indexOfMinimumElement should] equal:@(2)];
                [[indexOfMaximumElement should] equal:@(3)];
            });
        });
    });

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

        describe(@"reversedArray - EKAlgorithms implementation", ^{
            it(@"should return reversed array for a given array", ^{
                NSUInteger N = 100;

                NSMutableArray *originalArray = [NSMutableArray array];

                for (int i = 0; i < N; i++) {
                    [originalArray addObject:@(i + 1)];
                }

                NSArray *reversedArray = [originalArray reversedArray];

                for (int i = 0; i < N; i++) {
                    [[[reversedArray objectAtIndex:i] should] equal:[originalArray objectAtIndex:(originalArray.count - 1 - i)]];
                }
            });
        });
    });
    
    describe(@"sumOfElements", ^{
        it(@"should return sum of all elements in array", ^{
            NSArray *array = @[@1, @2, @3, @4, @5];
            [[[array sumOfElements] should] equal: @15];
        });
    });

    describe(@"Occurrences of each element in array", ^{
        describe(@"occurencesOfEachElementInArray", ^{
            specify(^{
                NSMutableArray *originalArray = [NSMutableArray array];

                // Just the array to test the method against
                // [@(1), @(2), @(2), @(3), @(3), @(3), ...]
                int N = 10;
                for (int i = 1; i <= N; i++) {
                    for (int j = 1; j <= i; j++) {
                        [originalArray addObject:@(i)];
                    }
                }

                NSDictionary *result = [originalArray occurencesOfEachElementInArray];

                for (int i = 1; i <= N; i++) {
                    [[result[@(i)] should] equal:@(i)];
                }
            });
        });

        describe(@"occurencesOfEachElementInArrayByUsingDictionary", ^{
            specify(^{
                NSMutableArray *originalArray = [NSMutableArray array];

                // Just the array to test the method against
                // [@(1), @(2), @(2), @(3), @(3), @(3), ...]
                int N = 10;
                for (int i = 1; i <= N; i++) {
                    for (int j = 1; j <= i; j++) {
                        [originalArray addObject:@(i)];
                    }
                }

                NSDictionary *result = [originalArray occurencesOfEachElementInArrayByUsingDictionary];

                for (int i = 1; i <= N; i++) {
                    [[result[@(i)] should] equal:@(i)];
                }
            });
        });
    });

});

SPEC_END
