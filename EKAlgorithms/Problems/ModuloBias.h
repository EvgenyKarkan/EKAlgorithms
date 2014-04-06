//
//  ModuloBias.h
//  EKAlgorithms
//
//  Created by Stanislaw Pankevich on 04/04/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


#import <assert.h>


/**
 The problem from coding interview:

 Write a random number generator which returns 0, 1, 2 or 3 given we have a generator which returns 0 or 1.
 */
static inline int random0123UsingRandom01() {
    // This is our magic 0-1 generator.
    int (^random01)(void) = ^int(void) {
        return arc4random_uniform(2);
    };

    int first  = random01();
    int second = random01();

    if (first == 1) {
        if (second == 1) {
            return 0;
        } else {
            return 1;
        }
    } else {
        if (second == 1) {
            return 2;
        } else {
            return 3;
        }
    }
}


/**
 Extended version of previous coding interview problem:

 Write a random number generator which returns one of {0, 1, ... up to (upperBound - 1)} given we have a generator which returns 0 or 1.
 
 This version also addresses the "Modulo bias problem":

 Objective C: Modulo bias
 http://stackoverflow.com/questions/648739/objective-c-modulo-bias?lq=1

 and 
 
 OpenBSD implementation of arc4random_uniform
 http://www.openbsd.org/cgi-bin/cvsweb/src/sys/dev/rnd.c?rev=1.140;content-type=text%2Fplain

 @warning This is by no means an efficient implementation - it is just an exercise! In real programs do use arc4random_uniform()
 */

static inline uint32_t randomUsingRandom01(uint32_t upperBound) {
    if (upperBound < 2) return 0;

    // This is our magic 0-1 generator.
    int (^random01)(void) = ^int(void) {
        return arc4random_uniform(2);
    };

    if (upperBound == 2) return random01();

    uint32_t (^randomForTwoPoweredUpperBound)(uint32_t) = ^uint32_t(uint32_t powerOfTwoPoweredUpperBound) {
        uint32_t randomNumber = 0;

        for (int i = 0; i < powerOfTwoPoweredUpperBound; i++) {
            if (random01() == 1) {
                randomNumber |= (1 << i);
            }
        }

        return randomNumber;
    };

    uint32_t powerOfTwoPoweredUpperBound = floor(log2(upperBound)) + 1;
    uint32_t twoPoweredUpperBound = 1 << powerOfTwoPoweredUpperBound; // same as pow(2, powerOfTwoPoweredUpperBound)

    uint32_t lowerBound = twoPoweredUpperBound % upperBound;

    uint32_t randomNumber;

    for (;;) {
        randomNumber = randomForTwoPoweredUpperBound(powerOfTwoPoweredUpperBound);

        if (randomNumber >= lowerBound) {
            break;
        }
    }

    return randomNumber % upperBound;
}

