//
//  EKBTree.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


#import "EKBTreeNode.h"

@interface EKBTree : NSObject

@property (nonatomic, strong) EKBTreeNode *root;

- (instancetype)initWithObject:(NSObject *)object;
- (BOOL)insertNode:(EKBTreeNode *)node parent:(EKBTreeNode *)parent isLeftChild:(BOOL)value;
- (EKBTreeNode *)find:(NSObject *)object;

- (void)preOrderTraversal;
- (void)inOrderTraversal;
- (void)postOrderTraversal;
- (void)levelOrderTraversal;

@end
