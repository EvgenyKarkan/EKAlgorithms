//
//  Node.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface EKNode : NSObject

@property (nonatomic, strong) NSObject *value;
@property (nonatomic, strong) EKNode   *previous;
@property (nonatomic, strong) EKNode   *next;

- (instancetype)initWithObject:(NSObject *)object;

@end
