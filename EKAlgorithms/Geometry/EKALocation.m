//
//  EKALocation.m
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 21/01/14.
//  Copyright (c) 2014 Stanislaw Pankevich. All rights reserved.
//

#import "EKALocation.h"

@implementation EKALocation

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude
{
    self = [super init];
    
    _latitude  = latitude;
    _longitude = longitude;
    
    return self;
}

@end
