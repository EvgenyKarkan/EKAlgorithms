//
//  EKTreeNode.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface EKBTreeNode : NSObject

@property (nonatomic, strong) NSObject    *object;
@property (nonatomic, strong) EKBTreeNode *leftChild;
@property (nonatomic, strong) EKBTreeNode *rightChild;
@property (nonatomic, strong) EKBTreeNode *parent;
@property (nonatomic, assign) SEL         compareSelector;

- (void)printDescription;
- (BOOL)isLeftChildOfParent;

@end
