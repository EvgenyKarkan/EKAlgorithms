//
//  JosephusProblem.h
//  EKAlgorithms
//
//  Created by Stanislaw Pankevich on 04/04/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import <assert.h>


/**
 Josephus Problem
 http://en.wikipedia.org/wiki/Josephus_problem
 
 http://stackoverflow.com/search?q=josephus, especially:

 http://stackoverflow.com/questions/21737771/can-someone-please-explain-the-use-of-modulus-in-this-code
 http://stackoverflow.com/questions/4845260/josephus-for-large-n-facebook-hacker-cup
 http://stackoverflow.com/questions/12479282/about-josephus-problem
 
 also: http://tristan-interview.blogspot.ru/2012/03/about-josephus-problem.html
 */


/**
 Josephus Problem (Naive implementation)
 http://en.wikipedia.org/wiki/Josephus_problem

 It is naive implementation of "killer iterator" which beheads elements using step of K, so the survivors (their number is always less than K) constitute a result. This method uses Cocoas NSMutableIndexSet, whereas other implementations often use circular linked list or circular buffer based on C array. This version is obviously slow compared to other functions that give direct result, but it can help visualize the whole process of 'killing' iterations.

 @note Operations of this method are 1-based

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

        /*
        printf("current iteration:\n");
        [elements enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            printf("%lu ", idx);
        }];
        printf("\n");
         */

        if ((currentN / K) > 0) {
            __block NSUInteger indexOfLastKilledElement = NSNotFound;

            [elements getIndexes:indexBuffer maxCount:currentN inIndexRange:NULL];

            for (NSUInteger indexOfIndex = (K - 1 - offset); indexOfIndex < currentN; indexOfIndex += K) {
                NSUInteger indexOfElement = indexBuffer[indexOfIndex];

                [indexesOfElementsToKill addIndex:indexOfElement];

                // printf("killing index %lu, %lu\n", indexOfElement, (indexOfElement < N - 1) ? indexBuffer[indexOfIndex + K] - indexOfElement : 0);

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


/**
 Josephus Problem (Wikipedia implementation)
 http://en.wikipedia.org/wiki/Josephus_problem

 @note Operations of this method are 1-based

 @return Returns survivor element.
 */
static inline NSUInteger JosephusProblemImplementationByWikipedia(NSUInteger N, NSUInteger K) {
    assert(K > 1);

    if (N == 1) {
        return 1;
    } else {
        return ((JosephusProblemImplementationByWikipedia(N - 1, K) + K - 1) % N) + 1;
    }
}


/**
 Josephus Problem (Wikipedia implementation N2)
 http://en.wikipedia.org/wiki/Josephus_problem

 @note Operations of this method are 1-based

 @return Returns survivor element.
 */
static inline NSUInteger JosephusProblemSecondImplementationByWikipedia(NSUInteger N, NSUInteger K) {
    assert(K > 1); // if (K == 1) return N;
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


/**
 Josephus Problem (Improved Wikipedia implementation)
 http://en.wikipedia.org/wiki/Josephus_problem and
 http://stackoverflow.com/questions/4845260/josephus-for-large-n-facebook-hacker-cup

 @note Should be used in cases when K is small and N is large.

 @note Computational complexity is O(K * log N) compared to O(N) of basic implementations

 @note Operations of this method are zero-based 

 @return Returns survivor element.
 */
static inline NSInteger JosephusProblemImprovedImplementationByWikipedia(NSInteger N, NSInteger K) {
    assert(K > 1); // or if (K == 1) return N - 1;

    if (N == 1) return 0;

    if (K > N) return (JosephusProblemImprovedImplementationByWikipedia(N - 1, K) + K) % N;
    
    NSInteger count = N / K;

    NSInteger result = JosephusProblemImprovedImplementationByWikipedia(N - count, K);

    result -= N % K;

    if (result < 0) {
        result += N;
    } else {
        result += result / (K - 1);
    }

    return result;
}
