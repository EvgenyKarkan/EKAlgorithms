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
                           andWeight:(NSObject *)weight
{
    self = [super init];
    if (self) {
        self.adjacentFrom = vertexFrom;
        self.adjacentTo = vertexTo;
        self.weight = weight;
        self.used = NO;
    }
    return self;
}

@end
