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

+ (NSArray *)sortArrayOfLocations:(NSArray *)array byDistanceToLocation:(EKALocation *)location
{
    for (EKALocation *_location in array) {
        _location->precalculatedDistanceToLocation = @(EKALocationDistanceToLocation(_location, location));
    }

    return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"precalculatedDistanceToLocation"
                                                                              ascending:YES]]];
}

@end
