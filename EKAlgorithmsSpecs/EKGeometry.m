#import "SpecHelpers.h"

#import <MapKit/MapKit.h>

#import "NSArray+EKStuff.h"
#import "NSArray+EKGeometry.h"
#import "EKALocation.h"
#import "EKGeometry.h"

// It is not used anywhere, but is useful for testing. Let it be here for a while
double RandomDoubleWithinRange(double min, double max) {
    double precision = 10000000;
    return ((double)arc4random_uniform((u_int32_t)((max - min) * precision))) / precision + min;
};

SPEC_BEGIN(NSArray_EKGeometry_Specs)

describe(@"EKGeometry.h algorithms", ^{
    describe(@"EKDistributionQuadrantForPointInsideMapRect", ^{
        specify(^{
            MKMapRect mapRect = MKMapRectMake(0, 0, 0, 0);
            MKMapPoint point;
            int quadrant;


            point = MKMapPointMake(0, 0);

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise(mapRect, point);
            [[theValue(quadrant) should] equal:@(0)];

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Branching(mapRect, point);
            [[theValue(quadrant) should] equal:@(0)];


            point = MKMapPointMake(RandomDoubleWithinRange(1, MKMapRectWorld.size.width), RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise(mapRect, point);
            [[theValue(quadrant) should] equal:@(0)];

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Branching(mapRect, point);
            [[theValue(quadrant) should] equal:@(0)];


            point = MKMapPointMake((-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.width), RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise(mapRect, point);
            [[theValue(quadrant) should] equal:@(1)];

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Branching(mapRect, point);
            [[theValue(quadrant) should] equal:@(1)];


            point = MKMapPointMake((-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.height), (-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise(mapRect, point);
            [[theValue(quadrant) should] equal:@(2)];

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Branching(mapRect, point);
            [[theValue(quadrant) should] equal:@(2)];


            point = MKMapPointMake(RandomDoubleWithinRange(1, MKMapRectWorld.size.width), (-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise(mapRect, point);
            [[theValue(quadrant) should] equal:@(3)];

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Branching(mapRect, point);
            [[theValue(quadrant) should] equal:@(3)];
        });
    });

    describe(@"EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative", ^{
        specify(^{
            MKMapRect mapRect = MKMapRectMake(0, 0, 0, 0);
            MKMapPoint point;
            int quadrant;

            point = MKMapPointMake(0, 0);

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative(mapRect, point);
            [[theValue(quadrant) should] equal:@(0)];

            point = MKMapPointMake(RandomDoubleWithinRange(1, MKMapRectWorld.size.width), RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative(mapRect, point);
            [[theValue(quadrant) should] equal:@(0)];


            point = MKMapPointMake((-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.width), RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative(mapRect, point);
            [[theValue(quadrant) should] equal:@(2)];


            point = MKMapPointMake((-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.height), (-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative(mapRect, point);
            [[theValue(quadrant) should] equal:@(3)];


            point = MKMapPointMake(RandomDoubleWithinRange(1, MKMapRectWorld.size.width), (-1) * RandomDoubleWithinRange(1, MKMapRectWorld.size.height));

            quadrant = EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative(mapRect, point);
            [[theValue(quadrant) should] equal:@(1)];
            
        });
    });

});

describe(@"NSArray+EKGeometry algorithms", ^{
    describe(@"+[NSArray sortArrayOfLocations:byDistanceToLocation:]", ^{
        it(@"should sort array of locations by a distance to given location", ^{
            NSMutableArray *originalLocations = [NSMutableArray array];

            EKALocation *referenceLocation = [[EKALocation alloc] initWithLatitude:0 longitude:0];

            // When N is greater than 1000, precision problems appear and break the test.
            double N = 1000;
            for (double i = 0; i < N; i++) {
                EKALocation *location = [[EKALocation alloc] initWithLatitude:(i * 90/ N) longitude:(i * 90/ N)];

                //CLLocation *location = [[CLLocation alloc] initWithLatitude:(i) longitude:(i)];
                //CLLocation *location = [[CLLocation alloc] initWithLatitude:RandomDoubleWithinRange(30, 30.10) longitude:RandomDoubleWithinRange(30, 30.10)];

                [originalLocations addObject:location];
            }

            NSArray *shuffledLocations = [originalLocations shuffledArray];

            NSArray *arraySortedByEKAlgorithm = [NSArray sortArrayOfLocations:shuffledLocations byDistanceToLocation:referenceLocation];

            [[theValue([arraySortedByEKAlgorithm isEqualToArray:originalLocations]) should] beYes];
        });
    });
});

SPEC_END
