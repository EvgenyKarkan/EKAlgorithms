//
//  LinkedList.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "LinkedList.h"
#import "Node.h"

@implementation LinkedList

- (instancetype)initWithHead:(NSObject *)value
{
	self = [super init];
	if (self) {
		self.head = [[Node alloc] initWithObject:value];
	}
	return self;
}

- (void)addToFront:(NSObject *)value
{
	Node *node = [[Node alloc] initWithObject:value];
    
	node.next = self.head;
	self.head.previous = node;
	self.head = node;
}

- (void)addToBack:(NSObject *)value
{
	Node *node = [[Node alloc] initWithObject:value];
    
	node.previous = self.tail;
	self.tail.next = node;
	self.tail = node;
}

@end
