//
//  LinkedList.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@class EKNode;

@interface EKLinkedList : NSObject

@property (nonatomic, strong) EKNode *head;
@property (nonatomic, strong) EKNode *tail;
@property (nonatomic, strong) EKNode *current;

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

- (NSArray *)findObject:(NSObject *)object;

- (BOOL)removeCurrent;
- (BOOL)removeObjectAtIndex:(NSUInteger)index;

- (void)printList;

- (void)reverseList;

@end
