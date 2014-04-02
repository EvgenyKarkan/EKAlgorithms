//
//  EKGeometry.h
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 22/03/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#ifndef EKAlgorithmsApp_EKGeometry_h
#define EKAlgorithmsApp_EKGeometry_h


typedef struct {
    double x;
    double y;
} EKAMapPoint;

typedef struct {
    double width;
    double height;
} EKAMapSize;

typedef struct {
    EKAMapPoint origin;
    EKAMapSize size;
} EKAMapRect;


static const EKAMapRect EKAMapRectWorld = {0, 0, 268435456.000000, 268435456.000000};

// Geometric operations on EKAMapPoint/Size/Rect.  See CGGeometry.h for
// information on the CGFloat versions of these functions.
NS_INLINE EKAMapPoint EKAMapPointMake(double x, double y) {
    return (EKAMapPoint){x, y};
}
NS_INLINE EKAMapSize EKAMapSizeMake(double width, double height) {
    return (EKAMapSize){width, height};
}
NS_INLINE EKAMapRect EKAMapRectMake(double x, double y, double width, double height) {
    return (EKAMapRect){ EKAMapPointMake(x, y), EKAMapSizeMake(width, height) };
}
NS_INLINE double EKAMapRectGetMinX(EKAMapRect rect) {
    return rect.origin.x;
}
NS_INLINE double EKAMapRectGetMinY(EKAMapRect rect) {
    return rect.origin.y;
}
NS_INLINE double EKAMapRectGetMidX(EKAMapRect rect) {
    return rect.origin.x + rect.size.width / 2.0;
}
NS_INLINE double EKAMapRectGetMidY(EKAMapRect rect) {
    return rect.origin.y + rect.size.height / 2.0;
}
NS_INLINE double EKAMapRectGetMaxX(EKAMapRect rect) {
    return rect.origin.x + rect.size.width;
}
NS_INLINE double EKAMapRectGetMaxY(EKAMapRect rect) {
    return rect.origin.y + rect.size.height;
}
NS_INLINE double EKAMapRectGetWidth(EKAMapRect rect) {
    return rect.size.width;
}
NS_INLINE double EKAMapRectGetHeight(EKAMapRect rect) {
    return rect.size.height;
}


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
NS_INLINE int EKDistributionQuadrantForPointInsideMapRect_Branching(EKAMapRect mapRect, EKAMapPoint point) {
    if (point.x >= EKAMapRectGetMidX(mapRect)) {
        if (point.y >=  EKAMapRectGetMidY(mapRect)) {
            return 0;
        } else {
            return 3;
        }
    } else {
        if (point.y >= EKAMapRectGetMidY(mapRect)) {
            return 1;
        } else {
            return 2;
        }
    }
}


/* There is bitwise version which is very useful for educational purposes but is slower than the code with simple branching (above)

   Detailed discussion on HashCode (russian StackOverflow): http://hashcode.ru/questions/306437)
 */
NS_INLINE int EKDistributionQuadrantForPointInsideMapRect_Bitwise(EKAMapRect mapRect, EKAMapPoint point) {
#define EK_LONG_LONG_SIGN (sizeof(long long) * 8 - 1)

    double dx = point.x - EKAMapRectGetMidX(mapRect);
    double dy = point.y - EKAMapRectGetMidY(mapRect);

    return ((*((long long *)&dy) >> EK_LONG_LONG_SIGN) & 3) ^ ((*((long long *)&dx) >> EK_LONG_LONG_SIGN) & 1);
}


/**
 There is bitwise version alternative to the one above - it works almost as fast as branching method does on Mac OS X and is slightly faster on Linux machines (we just measured this without knowing why is the difference)
 
 StackOverflow: "Optimizing quadrant selection" http://stackoverflow.com/questions/3313847/optimizing-quadrant-selection/
 
 Detailed discussion on HashCode (russian StackOverflow): http://hashcode.ru/questions/306437)

 @note Returns quadrants in incorrect order: 0 2 3 1

 @return Number of quadrant, one of 0, 2, 3, 1 (i.e. cartesian I, II, III, IV respectively)
 */
NS_INLINE int EKDistributionQuadrantForPointInsideMapRect_Bitwise_Alternative(EKAMapRect mapRect, EKAMapPoint point) {
#define EK_UINT64_SIGN (sizeof(uint64_t) * 8 - 1)

    double dx = point.x - EKAMapRectGetMidX(mapRect);
    double dy = point.y - EKAMapRectGetMidY(mapRect);

    return ((*((uint64_t *)&dx) >> (EK_UINT64_SIGN - 1)) & 2) | (*((uint64_t *)&dy) >> EK_UINT64_SIGN);
}

#endif
