//
//  NSArray+EKGeometry.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 20/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//


@class EKALocation;

@interface NSArray (EKGeometry)

/**
 Sort array of locations according to their distances to a given location

 @note Assumes array of EKALocation objects

 @return New array with locations sorted according to a distance to a given location.
 */
+ (NSArray *)sortArrayOfLocations:(NSArray *)array byDistanceToLocation:(EKALocation *)location;

@end
