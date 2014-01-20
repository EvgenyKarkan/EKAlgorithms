#import <Kiwi/Kiwi.h>

#import <MapKit/MapKit.h>

#import "NSArray+EKStuff.h"
#import "NSArray+EKGeometry.h"

// It is not used anywhere, but is useful for testing. Let it be here for a while
double RandomDoubleWithinRange(double min, double max) {
    double precision = 10000000;
    return ((double)arc4random_uniform((u_int32_t)((max - min) * precision))) / precision + min;
};

SPEC_BEGIN(NSArray_EKGeometry_Specs)

describe(@"NSArray+EKGeometry algorithms", ^{
    describe(@"+[NSArray sortArrayOfLocations:byDistanceToLocation:]", ^{
        it(@"should sort array of locations by a distance to given location", ^{
            NSMutableArray *sortedLocations = [NSMutableArray array];

            CLLocation *referenceLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];

            double N = 80;
            for (double i = 0; i < N; i++) {
                CLLocation *location = [[CLLocation alloc] initWithLatitude:i longitude:i];

                [sortedLocations addObject:location];
            }

            NSArray *shuffledLocations = [sortedLocations shuffledArray];

            NSArray *arraySortedByEKAlgorithm = [NSArray sortArrayOfLocations:shuffledLocations byDistanceToLocation:referenceLocation];

            [[theValue([arraySortedByEKAlgorithm isEqualToArray:sortedLocations]) should] beYes];
        });
    });
});

SPEC_END
