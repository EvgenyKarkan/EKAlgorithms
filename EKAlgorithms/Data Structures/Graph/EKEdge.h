//
//  EKEdge.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/22/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKVertex.h"

@interface EKEdge : NSObject

@property (nonatomic, strong) EKVertex *adjacentFrom;
@property (nonatomic, strong) EKVertex *adjacentTo;
@property (nonatomic, strong) NSNumber *weight;
@property (nonatomic, assign) BOOL     used;

- (instancetype)initWithAdjacentFrom:(EKVertex *)vertexFrom
                                  To:(EKVertex *)vertexTo
                           andWeight:(NSNumber *)weight;

@end
