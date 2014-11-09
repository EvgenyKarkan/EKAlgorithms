//
//  EKBTree.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKBTree.h"
#import "EKQueue.h"

#if TARGET_OS_IPHONE
#import "NSObject+EKComparisonForIOS.h"
#endif


@implementation EKBTree;

- (instancetype)initWithObject:(NSObject *)object
{
    if (self = [super init]) {
        _root            = [[EKBTreeNode alloc] init];
        self.root.object = object;
    }
    
    return self;
}

- (BOOL)insertNode:(EKBTreeNode *)node parent:(EKBTreeNode *)parent isLeftChild:(BOOL)value
{
    if (value == true && parent.leftChild == nil) {
        parent.leftChild = node;
    } else if (parent.rightChild == nil) {
        parent.rightChild = node;
    } else {
        NSAssert(parent.leftChild != nil || parent.rightChild != nil, @"Can't insert into parent node!");
        return false;
    }
    return true;
}

- (EKBTreeNode *)find:(NSObject *)object
{
    EKQueue *queue = [[EKQueue alloc] init];
    [queue insertObject:self.root];
    EKBTreeNode *node;
    while (![queue isEmpty]) {
        node = [queue removeFirstObject];
        if ([node.object isEqualTo:object]) {
            return node;
        }
        if (node.leftChild) {
            [queue insertObject:node.leftChild];
        }
        if (node.rightChild) {
            [queue insertObject:node.rightChild];
        }
    }
    return nil;
}

- (void)preOrderTraversal
{
    if (self.root) {
        [EKBTree preOrderTraversalRecursive:self.root];
    }
}

- (void)inOrderTraversal
{
    if (self.root) {
        [EKBTree inOrderTraversalRecursive:self.root];
    }
}

- (void)postOrderTraversal
{
    if (self.root) {
        [EKBTree postOrderTraversalRecursive:self.root];
    }
}

- (void)levelOrderTraversal
{
    if (self.root) {
        EKQueue *queue = [[EKQueue alloc] init];
        [queue insertObject:self.root];
        while (![queue isEmpty]) {
            EKBTreeNode *currentNode = [queue removeFirstObject];
            if (currentNode.leftChild) {
                [queue insertObject:currentNode.leftChild];
            }
            if (currentNode.rightChild) {
                [queue insertObject:currentNode.rightChild];
            }
            NSLog(@"%@", currentNode.object);
        }
    }
}

+ (void)preOrderTraversalRecursive:(EKBTreeNode *)node
{
    if (node) {
        NSLog(@"%@",node.object);
        [EKBTree preOrderTraversalRecursive:node.leftChild];
        [EKBTree preOrderTraversalRecursive:node.rightChild];
    }
}

+ (void)inOrderTraversalRecursive:(EKBTreeNode *)node
{
    if (node) {
        [EKBTree inOrderTraversalRecursive:node.leftChild];
        NSLog(@"%@",node.object);
        [EKBTree inOrderTraversalRecursive:node.rightChild];
    }
}

+ (void)postOrderTraversalRecursive:(EKBTreeNode *)node
{
    if (node) {
        [EKBTree postOrderTraversalRecursive:node.leftChild];
        [EKBTree postOrderTraversalRecursive:node.rightChild];
        NSLog(@"%@",node.object);
    }
}

@end
