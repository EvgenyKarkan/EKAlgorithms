//
//  EKBSTree.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


#import "EKBTreeNode.h"

@interface EKBSTree : NSObject

@property (nonatomic, strong) EKBTreeNode *root;

- (instancetype)initWithObject:(NSObject *)object compareSelector:(SEL)selector;
- (void)insertObject:(NSObject *)newObject;
- (void)printDescription;
- (EKBTreeNode *)find:(NSObject *)object;
- (EKBTreeNode *)deleteObject:(NSObject *)object;

@end
