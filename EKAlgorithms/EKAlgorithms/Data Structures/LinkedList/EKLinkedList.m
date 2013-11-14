//
//  LinkedList.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKLinkedList.h"
#import "EKNode.h"

@implementation EKLinkedList

- (instancetype)initWithHead:(NSObject *)value
{
	self = [super init];
    
	if (self) {
		self.head = [[EKNode alloc] initWithObject:value];
	}
	return self;
}

- (void)addToFront:(NSObject *)value
{
	EKNode *node = [[EKNode alloc] initWithObject:value];
    
	node.next = self.head;
	self.head.previous = node;
	self.head = node;
}

- (void)addToBack:(NSObject *)value
{
	EKNode *node = [[EKNode alloc] initWithObject:value];
    
	node.previous = self.tail;
	self.tail.next = node;
	self.tail = node;
}

- (void)insertObject:(NSObject *)object AtIndex:(NSUInteger)index
{
	EKNode *currentNode = self.head;
	EKNode *previousNode = nil;
	EKNode *nextNode = nil;
    
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
		newNode.previous = previousNode;
        
		nextNode.previous = newNode;
		newNode.next = nextNode;
	}
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
	if (!self.head) {
		return 0;
	}
    
	EKNode *currentNode = self.head;
	NSUInteger i = 1;
    
	while (currentNode.next) {
		currentNode = currentNode.next;
		i++;
	}
	return i;
}

- (NSObject *)objectAtIndex:(NSUInteger)index
{
	EKNode *currentNode = self.head;
    
	for (NSUInteger i = 1; i < index; i++) {
		currentNode = currentNode.next;
	}
    
	return currentNode.value;
}


@end
