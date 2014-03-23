//
//  EKGeometry.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 22/03/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#ifndef EKAlgorithmsApp_EKGeometry_h
#define EKAlgorithmsApp_EKGeometry_h

#import <MapKit/MapKit.h>


/**
 Find quadrant which a given point is distributed to from a center of a given map rect
 Wikipedia: http://en.wikipedia.org/wiki/Cartesian_coordinate_system#Quadrants_and_octants

 @code
 -----
| 1 0 |
|  c  | c - center of map rect.
| 2 3 |
 -----
 @endcode

 @note This branching version is faster than another version with bitwise operations (also present here below)!
 @note Special case: if you take mapRect as {.origin.x = 0, .origin.y = 0, .size.width = 0, .size.height = 0}, you will have the common four quadrants of a Cartesian coordinate system with (0, 0) as center point.

 @return Number of quadrant, one of 0, 1, 2, 3 (i.e. cartesian I, II, III, IV respectively)
 */
NS_INLINE int EKDistributionQuadrantForPointInsideMapRect_Branching(MKMapRect mapRect, MKMapPoint point) {
    if (point.x >= MKMapRectGetMidX(mapRect)) {
        if (point.y >=  MKMapRectGetMidY(mapRect)) {
            return 0;
        } else {
            return 3;
        }
    } else {
        if (point.y >= MKMapRectGetMidY(mapRect)) {
            return 1;
        } else {
            return 2;
        }
    }
}


/* There is bitwise version which is very useful for educational purposes but is slower than the code with simple branching (above)

   Detailed discussion on HashCode (russian StackOverflow): http://hashcode.ru/questions/306437)
 */
NS_INLINE int EKDistributionQuadrantForPointInsideMapRect_Bitwise(MKMapRect mapRect, MKMapPoint point) {
#define EK_LONG_LONG_SIGN (sizeof(long long) * 8 - 1)

    double dx = point.x - MKMapRectGetMidX(mapRect);
    double dy = point.y - MKMapRectGetMidY(mapRect);

    return ((*((long long *)&dy) >> EK_LONG_LONG_SIGN) & 3) ^ ((*((long long *)&dx) >> EK_LONG_LONG_SIGN) & 1);
}


/**
 There is bitwise version alternative to the one above - it works almost as fast as branching method does on Mac OS X and is slightly faster on Linux machines (we just measured this without knowing why is the difference)
 
 StackOverflow: "Optimizing quadrant selection" http://stackoverflow.com/questions/3313847/optimizing-quadrant-selection/
 
 Detailed discussion on HashCode (russian StackOverflow): http://hashcode.ru/questions/306437)

 @note Returns quadrants in incorrect order: 0 2 3 1

 @return Number of quadrant, one of 0, 2, 3, 1 (i.e. cartesian I, II, III, IV respectively)
 */
NS_INLINE int EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative(MKMapRect mapRect, MKMapPoint point) {
#define EK_UINT64_SIGN (sizeof(uint64_t) * 8 - 1)

    double dx = point.x - MKMapRectGetMidX(mapRect);
    double dy = point.y - MKMapRectGetMidY(mapRect);

    return ((*((uint64_t *)&dx) >> (EK_UINT64_SIGN - 1)) & 2) | (*((uint64_t *)&dy) >> EK_UINT64_SIGN);
}

#endif
