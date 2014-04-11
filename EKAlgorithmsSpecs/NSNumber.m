
#import "SpecHelpers.h"
#import "NSNumber+EKStuff.h"

SPEC_BEGIN(NSNumber_Specs)

describe(@"NSNumber-based algorithms", ^{
    describe(@"isEven", ^{
        it(@"should return YES if number is even and NO otherwise", ^{
            int N = 100;

            for (int i = 0; i < N; i++) {
                BOOL isEvenMathematically = [@(i % 2) boolValue] == NO;

                [[theValue([@(i) isEven]) should] equal:@(isEvenMathematically)];

                if ([@(i) isEven]) {
                    [[theValue([@(i + 1) isEven]) should] beNo];
                } else {
                    [[theValue([@(i + 1) isEven]) should] beYes];
                }
            }
        });
    });
});

SPEC_END
