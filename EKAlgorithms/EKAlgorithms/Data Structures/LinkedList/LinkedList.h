//
//  LinkedList.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Node;

@interface LinkedList : NSObject

@property (nonatomic, strong) Node *head;
@property (nonatomic, strong) Node *tail;
@property (nonatomic, strong) Node *current;

- (instancetype)initWithHead:(NSObject *)value;

- (void)addToFront:(NSObject *)value;
- (void)addToBack:(NSObject *)value;

- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index;

- (NSObject *)first;
- (NSObject *)currentValue;
- (NSObject *)next;
- (NSObject *)previous;

- (NSUInteger)count;
- (NSObject *)objectAtIndex:(NSUInteger)index;

- (BOOL)removeCurrent;
- (BOOL)removeObjectAtIndex:(NSUInteger)index;

@end
