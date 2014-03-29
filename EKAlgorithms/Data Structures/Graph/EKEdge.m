//
//  EKEdge.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/22/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKEdge.h"

@implementation EKEdge

- (instancetype)initWithAdjacentTo:(EKVertex *)vertex andWeight:(NSObject *)weight
{
    self = [super init];
    if (self) {
        self.adjacentTo = vertex;
        self.weight = weight;
    }
    return self;
}

@end
