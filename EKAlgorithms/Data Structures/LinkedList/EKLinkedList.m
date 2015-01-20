//
//  LinkedList.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKLinkedList.h"
#import "EKNode.h"

#if TARGET_OS_IPHONE
#import "NSObject+EKComparisonForIOS.h"
#endif

@interface EKLinkedList ()
{
    NSUInteger _count;
}

@end

@implementation EKLinkedList;

- (instancetype)initWithHead:(NSObject *)value
{
    self = [super init];
    
    if (self) {
        _head = [[EKNode alloc] initWithObject:value];
        _count = 1;
    }
    return self;
}

- (void)addToFront:(NSObject *)value
{
    EKNode *node = [[EKNode alloc] initWithObject:value];
    
    if (self.tail == nil) {
        EKNode *lastNode = self.head;
        for (NSUInteger i = 1; i < _count; i++) {
            lastNode = lastNode.next;
        }
        self.tail = lastNode;
        
    }
    node.next          = self.head;
    self.head.previous = node;
    self.head          = node;
    
    _count++;
}

- (void)addToBack:(NSObject *)value
{
    EKNode *node = [[EKNode alloc] initWithObject:value];
    
    if (self.tail == nil) {
        EKNode *lastNode = self.head;
        for (NSUInteger i = 1; i < _count; i++) {
            lastNode = lastNode.next;
        }
        self.tail = lastNode;
    }
    node.previous  = self.tail;
    self.tail.next = node;
    self.tail      = node;
    
    _count++;
}

- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index
{
    EKNode *currentNode  = self.head;
    EKNode *previousNode = nil;
    EKNode *nextNode     = nil;
    
    for (NSUInteger i = 1; i <= index; i++) {
        currentNode = currentNode.next;
        if (i == index - 1) {
            previousNode = currentNode;
        }
        else if (i == index) {
            nextNode = currentNode;
        }
    }
    
    EKNode *newNode = [[EKNode alloc] initWithObject:object];
    
    if (!previousNode) {
        self.head = newNode;
    }
    else {
        previousNode.next = newNode;
        newNode.previous  = previousNode;
        
        nextNode.previous = newNode;
        newNode.next      = nextNode;
    }
    _count++;
}

- (NSObject *)first
{
    return self.head.value;
}

- (NSObject *)currentValue
{
    return self.current.value;
}

- (NSObject *)next
{
    self.current = self.current.next;
    
    return self.current.value;
}

- (NSObject *)previous
{
    self.current = self.current.previous;
    
    return self.current.value;
}

- (NSUInteger)count
{
    return _count;
}

- (NSObject *)objectAtIndex:(NSUInteger)index
{
    EKNode *currentNode = self.head;
    
    for (NSUInteger i = 1; i < index; i++) {
        currentNode = currentNode.next;
    }
    
    return currentNode.value;
}

- (NSArray *)findObject:(NSObject *)object
{
    if (object) {
        NSMutableArray *result = [@[] mutableCopy];
        EKNode *currentNode    = self.head;
        
        while (currentNode.next != nil) {
            if ([currentNode.value isEqualTo:object]) {
                [result addObject:currentNode];
            }
            currentNode = currentNode.next;
        }
        return result;
    }
    return nil;
}

- (BOOL)removeCurrent
{
    //FIXME: improve code below
    NSLog(@"<#   #> %@", [self currentValue]);
    
    BOOL removed = NO;
    if (self.current != nil) {
        self.current.previous.next = self.current.next;
        removed = YES;
        _count--;
    }
    else {
        removed = NO;
    }
    
    return removed;
}

- (BOOL)removeObjectAtIndex:(NSUInteger)index
{
    if (index < 1 || index > [self count]) {
        NSLog(@"You are trying to delete head or index out of list count");
        return NO;
    }
    
    EKNode *current = self.head;
    
    for (NSUInteger i = 1; i < index; i++) {
        if (current.next == nil) {
            return NO;
        }
        current = current.next;
    }
    
    current.next = current.next.next;
    _count--;
    
    return YES;
}

- (void)printList
{
    EKNode *node = self.head;
    
    while (node != nil) {
        NSLog(@"Node %@", node.value);
        node = node.next;
    }
}

- (void)reverseList
{
    self.current = self.head;
    
    EKNode *previousNode = nil;
    EKNode *nextNode     = nil;
    
    while (self.current) {
        nextNode          = self.current.next;
        self.current.next = previousNode;
        
        previousNode      = self.current;
        self.current      = nextNode;
    }
    
    self.head = previousNode;
}

@end
