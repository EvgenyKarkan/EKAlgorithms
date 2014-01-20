#import <Kiwi/Kiwi.h>

#import "NSArray+EKGeometry.h"

SPEC_BEGIN(NSArray_EKGeometry_Specs)

describe(@"NSArray+EKGeometry algorithms", ^{
    describe(@"+[NSArray sortArrayOfLocations:byDistanceToLocation:]", ^{
        it(@"should sort array of locations by a distance to given location", ^{
            NSMutableArray *locations = [NSMutableArray array];

            CLLocation *zeroLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];

            double N = 80;
            for (double i = 0; i < N; i++) {
                CLLocation *location = [[CLLocation alloc] initWithLatitude:i longitude:i];
                [locations insertObject:location atIndex:0];
            }

            NSArray *sortedArrayOfLocations = [NSArray sortArrayOfLocations:locations byDistanceToLocation:zeroLocation];

            [sortedArrayOfLocations enumerateObjectsUsingBlock:^(CLLocation *location, NSUInteger idx, BOOL *stop) {
                [[theValue(location.coordinate.latitude) should] equal:@(idx)];
            }];
        });

    });
});

SPEC_END
