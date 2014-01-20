//
//  NSArray+EKGeometry.m
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 20/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import "NSArray+EKGeometry.h"

@implementation NSArray (EKGeometry)

+ (NSArray *)sortArrayOfLocations:(NSArray *)array byDistanceToLocation:(CLLocation *)location {
    CLLocationDegrees lat = location.coordinate.latitude;
    CLLocationDegrees lng = location.coordinate.longitude;

    return [array sortedArrayUsingComparator:^NSComparisonResult(CLLocation *location1, CLLocation *location2) {
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


        /* Example of more efficient algorithm. Don't forget about "distance is not the same distance" for a different regions of world map, but if you don't care about this precision, the following algo works pretty fine */

        
        CLLocationDegrees lat1 = location1.coordinate.latitude;
        CLLocationDegrees lng1 = location1.coordinate.longitude;

        CLLocationDegrees lat2 = location2.coordinate.latitude;
        CLLocationDegrees lng2 = location2.coordinate.longitude;


        // Comparison of distance beetween location1 and location and distance beetween location2 and location
        // is equivalent to
        // Comparison of squared distance beetween location1 and location and squared distance beetween location2 and location:
        //
        // (pow(lat - lat1, 2) + pow(lng - lng1, 2)) with (pow(lat - lat2, 2) + pow(lng - lng2, 2)) (1*)
        //
        // since comparison of a with b is the same as comparison of (a - b) with 0 (2*)
        // and
        // mathematically pow(a + b, 2) is equivalent to pow(a, 2) + 2 * a * b + pow(b, 2) (3*)
        //
        // we can expand equation (1*) applying 2* and 3* to get:

        CLLocationDegrees differenceBeetweenSquaredDistances =
            pow(lat1, 2) + pow(lng1, 2) - pow(lat2, 2) - pow(lng2, 2) // (4*)
            + 2 * ((lat2 - lat1) * lat + (lng2 - lng1) * lng);


        // the last thing to note is that
        // if faster calculation is needed: these squares (4*) can be pre-calculated or cached after their first calculation for each location:
        // Fx, just add @squaredLatitude, @squaredLongitude properties to some CLLocation subclass and use it as a replacement for CLLocation.
        // This caching trick gives stable ~2x performance boost (tested on 100, 1000, 10000, 100000 numbers of locations)

        if (differenceBeetweenSquaredDistances > 0) {
            return (NSComparisonResult)NSOrderedDescending;
        }

        if (differenceBeetweenSquaredDistances < 0) {
            return (NSComparisonResult)NSOrderedAscending;
        }

        return (NSComparisonResult)NSOrderedSame;
    }];
}

@end
