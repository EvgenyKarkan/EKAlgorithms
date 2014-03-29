//
//  EKTree.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKTreeNode.h"

@class EKBTree;

@interface EKTree : NSObject

@property (nonatomic, strong) EKTreeNode *root;

- (instancetype)initWithObject:(NSObject *)object;
- (void)insertNode:(EKTreeNode *)node leftSibling:(EKTreeNode *)leftSibling parent:(EKTreeNode *)parent;
- (void)printDescription;

+ (EKBTree *)forestToBinaryTree:(NSArray *)trees;

@end
