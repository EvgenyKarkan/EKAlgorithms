
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
    
    describe(@"isPrime", ^{
        it(@"should return YES if number is prime and NO otherwise", ^{
            int N = 100;
            NSArray *primesUnderN = @[ @2, @3, @5, @7, @11, @13, @17, @19, @23, @29, @31, @37, @41, @43, @47, @53, @59, @61, @67, @71, @73, @79, @83, @89, @97];
            
            for (int i = 0; i < N; i++) {
                if ([primesUnderN containsObject:@(i)]) {
                    [[theValue([@(i) isPrime]) should] beYes];
                } else {
                    [[theValue([@(i) isPrime]) should] beNo];
                }
            }
        });
    });
});

SPEC_END
