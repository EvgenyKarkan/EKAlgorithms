//
//  EKAVLTree.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/29/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

@class EKAVLTreeNode;


@interface EKAVLTree : NSObject

@property (nonatomic, strong) EKAVLTreeNode *root;

- (instancetype)initWithObject:(NSObject *)object;
- (void)insertObject:(NSObject *)newObject;
- (void)printDescription;
- (EKAVLTreeNode *)find:(NSObject *)object;
- (void)deleteObject:(NSObject *)object;

@end
