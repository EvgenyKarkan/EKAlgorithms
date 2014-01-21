//
//  NSArray+EKGeometry.m
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 20/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import "NSArray+EKGeometry.h"

#import "EKALocation.h"

@implementation NSArray (EKGeometry)


+ (NSArray *)sortArrayOfLocations:(NSArray *)array byDistanceToLocation:(CLLocation *)location {
    for (EKALocation *_location in array) {
        _location->precalculatedDistanceToLocation = nil;
    }

    return [array sortedArrayUsingComparator:^NSComparisonResult(EKALocation *location1, EKALocation *location2) {
        /*
         Naive version:

         if ([location distanceFromLocation:obj1location] > [location distanceFromLocation:obj2location]) {
         return (NSComparisonResult)NSOrderedDescending;
         }

         if ([location distanceFromLocation:obj1location] < [location distanceFromLocation:obj2location]) {
         return (NSComparisonResult)NSOrderedAscending;
         }

         return (NSComparisonResult)NSOrderedSame;
         */


        if (location1->precalculatedDistanceToLocation == nil) {
            location1->precalculatedDistanceToLocation = @([location distanceFromLocation:location1]);
        }

        if (location2->precalculatedDistanceToLocation == nil) {
            location2->precalculatedDistanceToLocation = @([location distanceFromLocation:location2]);
        }

        return [location1->precalculatedDistanceToLocation compare:location2->precalculatedDistanceToLocation];
    }];
}


@end
