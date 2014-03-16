//
//  NSArray+EKGeometry.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 20/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface NSArray (EKGeometry)


/**
 Sort array of locations according to their distances to a given location

 @note Assumes array of EKALocation objects

 @return New array with locations sorted according to a distance to a given location.
 */
+ (NSArray *)sortArrayOfLocations:(NSArray *)array byDistanceToLocation:(CLLocation *)location;

@end
