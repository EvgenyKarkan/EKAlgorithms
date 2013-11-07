//
//  Node.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) NSObject *value;
@property (nonatomic, strong) Node *previous;
@property (nonatomic, strong) Node *next;

- (instancetype)initWithObject:(NSObject *)object;

@end
