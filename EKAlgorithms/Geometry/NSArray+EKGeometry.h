//
//  NSArray+EKGeometry.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 20/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSArray (EKGeometry)


/**
 Sort array of locations according to their distances to a given location

 @note Assumes array of CLLocation objects
 
 @warning Be careful with distances on real world map: though this algorithm is correct mathematically, it does not handle the fact that distances beetween map points calculated with raw math are not the same as the distances beetween these points on a real earth's surface. Use this algorithm, if you don't need this precision for your calculations of map points, locations etc.

 @return New array with locations sorted according to a distance to a given location.
 */
+ (NSArray *)sortArrayOfLocations:(NSArray *)array byDistanceToLocation:(CLLocation *)location;

@end
