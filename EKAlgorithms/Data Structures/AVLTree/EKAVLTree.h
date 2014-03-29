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

- (instancetype)initWithObject:(NSObject *)object compareSelector:(SEL)selector;
- (void)insertObject:(NSObject *)newObject;
- (void)printDescription;
- (EKAVLTreeNode *)find:(NSObject *)object;

+ (NSInteger)heightOfNode:(EKAVLTreeNode *)node;

+ (EKAVLTreeNode *)singleRotateWithLeft:(EKAVLTreeNode *)K2;
+ (EKAVLTreeNode *)singleRotateWithRight:(EKAVLTreeNode *)K2;
+ (EKAVLTreeNode *)doubleRotateWithLeft:(EKAVLTreeNode *)K3;
+ (EKAVLTreeNode *)doubleRotateWithRight:(EKAVLTreeNode *)K3;

@end
