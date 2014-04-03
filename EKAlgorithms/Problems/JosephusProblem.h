//
//  EKA_JosephusProblem.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 04/04/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import <assert.h>


/**
 Josephus Problem
 http://en.wikipedia.org/wiki/Josephus_problem

 It is naive implementation of "killer iterator" which beheads elements using step of K, so the survivors (their number is always less than K) constitute a result.

 There is obviously a much more efficient solution, but this is another story.

 @return Returns index set with indexes of survivor elements.
 */
static inline NSIndexSet *JosephusProblemNaiveImplementation(NSUInteger N, NSUInteger K) {
    assert(K > 1);
    assert(K <= N);

    NSMutableIndexSet *elements = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(1, N)];

    typedef void (^recursiveKillingIterationBlock)(NSUInteger offset);

    __block
    recursiveKillingIterationBlock weakRecursiveKillingIteration;
    recursiveKillingIterationBlock recursiveKillingIteration;

    __block NSUInteger *indexBuffer = malloc(N * sizeof(NSUInteger));

    NSMutableIndexSet *indexesOfElementsToKill = [NSMutableIndexSet indexSet];

    weakRecursiveKillingIteration = recursiveKillingIteration = ^void(NSUInteger offset) {
        NSUInteger currentN = elements.count;

        if ((currentN / K) > 0) {
            __block NSUInteger indexOfLastKilledElement = NSNotFound;

            [elements getIndexes:indexBuffer maxCount:currentN inIndexRange:NULL];

            for (NSUInteger indexOfIndex = (K - 1 - offset); indexOfIndex < currentN; indexOfIndex += K) {
                NSUInteger indexOfElement = indexBuffer[indexOfIndex];

                [indexesOfElementsToKill addIndex:indexOfElement];

                indexOfLastKilledElement = indexOfIndex;
            };

            [elements removeIndexes:indexesOfElementsToKill];

            [indexesOfElementsToKill removeAllIndexes];

            weakRecursiveKillingIteration(currentN % (indexOfLastKilledElement + 1));
        }
    };

    recursiveKillingIteration(0);

    free(indexBuffer);

    return [elements copy];
}

static inline NSUInteger JosephusProblemImplementationByWikipedia(NSUInteger N, NSUInteger K) {
    assert(K > 1);
    assert(K <= N);

    typedef NSUInteger (^josephusProblemBlock)(NSUInteger N, NSUInteger K, NSUInteger startingPoint);

    __block
    josephusProblemBlock weakJosephusProblem;
    josephusProblemBlock JosephusProblem;

    weakJosephusProblem = JosephusProblem = ^NSUInteger(NSUInteger N, NSUInteger K, NSUInteger startingPoint) {
        if (N == 1) {
            return 1;
        }

        NSUInteger newSp = (startingPoint + K - 2) % N + 1;

        NSUInteger survivor = weakJosephusProblem(N - 1, K, newSp);

        if (survivor < newSp) {
            return survivor;
        } else {
            return survivor + 1;
        }
    };
    
    return JosephusProblem(N, K, 1);
}
