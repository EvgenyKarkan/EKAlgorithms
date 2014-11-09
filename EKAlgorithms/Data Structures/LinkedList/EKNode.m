//
//  Node.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKNode.h"


@implementation EKNode;

- (instancetype)initWithObject:(NSObject *)object
{
    if (self = [super init]) {
        _value = object;
    }
    return self;
}

@end
