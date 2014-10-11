//
//  EKAVLTreeNode.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/29/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


@interface EKAVLTreeNode : NSObject

@property (nonatomic, assign) NSInteger     height;
@property (nonatomic, strong) NSObject      *object;
@property (nonatomic, strong) EKAVLTreeNode *leftChild;
@property (nonatomic, strong) EKAVLTreeNode *rightChild;
@property (nonatomic, assign) SEL           compareSelector;

- (void)printDescription;

@end
