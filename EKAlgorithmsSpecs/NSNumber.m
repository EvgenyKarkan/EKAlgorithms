
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

    describe(@"Josephus Problem", ^{
        it(@"", ^{
            // N = 4, K = 2, 3, 4
            {
                NSUInteger N = 4;

                NSIndexSet *indexesOfElementsSurvived;

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:2];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(1)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:3];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(2)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(4)];

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:4];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(3)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(3)];
            }

            // N = 5, K = 2, 3, 4, 5
            {
                NSUInteger N = 5;
                
                NSIndexSet *indexesOfElementsSurvived;

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:2];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(1)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(3)];

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:3];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(2)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(2)];
                [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(4)];

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:4];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(3)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(5)];

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:5];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(4)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(4)];
            }

            // N = 6, K = 3
            {
                NSUInteger N = 6;

                NSIndexSet *indexesOfElementsSurvived;

                indexesOfElementsSurvived = [NSNumber JosephusProblem:N K:3];

                [[theValue(indexesOfElementsSurvived.count) should] equal:@(2)];
                [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(5)];
            }
        });
    });

});

SPEC_END
