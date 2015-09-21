//
//  EKALocation.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 21/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKALocation : NSObject {
    @public
    NSNumber *precalculatedDistanceToLocation;
}

@property double latitude;
@property double longitude;

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude;

@end


static inline double EKALocationDistanceToLocation(EKALocation *location1, EKALocation *location2) {
    return sqrt(pow(location1.latitude - location2.latitude, 2) + pow(location1.longitude - location2.longitude, 2));
}

