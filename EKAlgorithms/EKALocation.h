//
//  EKALocation.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 21/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface EKALocation : CLLocation {
    @public
    NSNumber *precalculatedDistanceToLocation;
}

@end
