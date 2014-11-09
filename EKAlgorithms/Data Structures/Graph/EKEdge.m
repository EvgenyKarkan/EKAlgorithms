//
//  EKEdge.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/22/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKEdge.h"

@implementation EKEdge

- (instancetype)initWithAdjacentFrom:(EKVertex *)vertexFrom
                                  To:(EKVertex *)vertexTo
                           andWeight:(NSNumber *)weight
{
    self = [super init];
    
    if (self) {
        _adjacentFrom = vertexFrom;
        _adjacentTo   = vertexTo;
        _weight       = weight;
        _used         = NO;
    }
    return self;
}

@end
