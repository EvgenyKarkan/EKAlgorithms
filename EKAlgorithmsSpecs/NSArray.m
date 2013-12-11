#import <Kiwi/Kiwi.h>

#import "NSArray+EKStuff.h"

SPEC_BEGIN(NSArray_Specs)

describe(@"NSArray-based algorithms", ^{
    describe(@"Search algorithms", ^{
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
});

SPEC_END
