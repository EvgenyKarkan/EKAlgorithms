//
//  EKTree.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKTree.h"
#import "EKBTree.h"
#import "EKQueue.h"

#if TARGET_OS_IPHONE
#import "NSObject+EKComparisonForIOS.h"
#endif


@implementation EKTree;

- (instancetype)initWithObject:(NSObject *)object
{
    if (self = [super init]) {
        _root            = [[EKTreeNode alloc] init];
        self.root.object = object;
        self.root.parent = nil;
    }
    
    return self;
}

- (void)insertNode:(EKTreeNode *)node leftSibling:(EKTreeNode *)leftSibling parent:(EKTreeNode *)parent
{
    node.parent = parent;
    
    if (leftSibling == nil) {
        parent.child = node;
    }
    else {
        leftSibling.sibling = node;
    }
}

- (void)printDescription
{
    [self.root printDescription];
}

+ (EKBTree *)forestToBinaryTree:(NSArray *)trees
{
    if ([trees count] > 0) {
            // Union trees
        EKTree *previous = trees[0];
        for (EKTree *tree in trees) {
            if (tree != previous) {
                previous.root.sibling = tree.root;
                previous              = tree;
            }
        }
        EKQueue *queue = [[EKQueue alloc] init];
        [queue insertObject:((EKTree *)trees[0]).root];
        EKBTree *result = [[EKBTree alloc] initWithObject:((EKTreeNode *)[queue peek]).object];
        
            // Create binary tree
        while (![queue isEmpty]) {
            EKTreeNode *node  = [queue removeFirstObject];
            EKBTreeNode *root = [result find:node.object];
            
            if (node.child) {
                [queue insertObject:node.child];
                root.leftChild        = [[EKBTreeNode alloc] init];
                root.leftChild.object = node.child.object;
                root.leftChild.parent = root;
            }
            if (node.sibling) {
                [queue insertObject:node.sibling];
                root.rightChild        = [[EKBTreeNode alloc] init];
                root.rightChild.object = node.sibling.object;
                root.rightChild.parent = root;
            }
        }
        return result;
    }
    else {
        NSAssert([trees count] > 0, @"There is no tree in array!");
        return nil;
    }
}
@end
