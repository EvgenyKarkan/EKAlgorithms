
#import "NSNumber+EKStuff.h"


FOUNDATION_EXPORT uint64_t dispatch_benchmark(size_t count, void (^block)(void));


#define Benchmark(n, block) \
do { \
float time = (float)dispatch_benchmark(n, block); \
printf("The block have been run %d times. Average time is: %f milliseconds\n", n, (time / 1000000)); \
} while (0);


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
