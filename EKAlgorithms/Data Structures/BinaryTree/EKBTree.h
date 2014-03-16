//
//  EKBTree.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKBTreeNode.h"

@interface EKBTree : NSObject

@property (nonatomic, strong) EKBTreeNode *root;

- (instancetype)initWithObject:(NSObject *)object;
- (BOOL)insertNode:(EKBTreeNode *)node parent:(EKBTreeNode *)parent isLeftChild:(BOOL)value;
- (void)preOrderTraversal;
- (void)inOrderTraversal;
- (void)postOrderTraversal;

@end
