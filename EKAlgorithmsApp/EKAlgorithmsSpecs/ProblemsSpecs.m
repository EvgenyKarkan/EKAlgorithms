
#import "JosephusProblem.h"

SPEC_BEGIN(ProblemsSpecs)

describe(@"Problems", ^{
    describe(@"Josephus Problem", ^{
        describe(@"'Killer iterator' version", ^{
            it(@"", ^{
                // N = 4, K = 2, 3, 4
                {
                    NSUInteger N = 4;

                    NSIndexSet *indexesOfElementsSurvived;

                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 2);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(1)];
                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];


                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 3);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(2)];

                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                    [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(4)];

                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 4);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(3)];
                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                    [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(3)];
                }

                // N = 5, K = 2, 3, 4, 5
                {
                    NSUInteger N = 5;

                    NSIndexSet *indexesOfElementsSurvived;

                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 2);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(1)];
                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(3)];

                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 3);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(2)];
                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(2)];
                    [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(4)];

                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 4);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(3)];
                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                    [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(5)];

                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 5);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(4)];
                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                    [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(4)];
                }

                // N = 6, K = 3
                {
                    NSUInteger N = 6;

                    NSIndexSet *indexesOfElementsSurvived;

                    indexesOfElementsSurvived = JosephusProblemNaiveImplementation(N, 3);

                    [[theValue(indexesOfElementsSurvived.count) should] equal:@(2)];
                    [[theValue(indexesOfElementsSurvived.firstIndex) should] equal:@(1)];
                    [[theValue(indexesOfElementsSurvived.lastIndex) should] equal:@(5)];
                }
            });

            JosephusProblemNaiveImplementation(100, 3);
        });

        describe(@"Wikipedia version", ^{
            it(@"", ^{
                NSUInteger survivor;
                
                survivor = JosephusProblemImplementationByWikipedia(5, 2);
                
                [[theValue(survivor) should] equal:@(3)];
                
                survivor = JosephusProblemImplementationByWikipedia(5, 3);

                [[theValue(survivor) should] equal:@(4)];
                
                survivor = JosephusProblemImplementationByWikipedia(6, 3);

                [[theValue(survivor) should] equal:@(1)];
            });
        });

        describe(@"Improved Wikipedia version", ^{
            it(@"", ^{
                NSUInteger survivor;

                survivor = JosephusProblemImprovedImplementationByWikipedia(5, 2);
                [[theValue(survivor) should] equal:@(2)];

                survivor = JosephusProblemImprovedImplementationByWikipedia(5, 3);

                [[theValue(survivor) should] equal:@(3)];

                survivor = JosephusProblemImprovedImplementationByWikipedia(6, 3);

                [[theValue(survivor) should] equal:@(0)];
            });
        });

    });
    
});

SPEC_END
