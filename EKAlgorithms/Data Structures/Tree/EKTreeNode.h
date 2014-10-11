//
//  EKTreeNode.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


@interface EKTreeNode : NSObject

@property (nonatomic, strong) NSObject   *object;
@property (nonatomic, strong) EKTreeNode *child;
@property (nonatomic, strong) EKTreeNode *sibling;
@property (nonatomic, strong) EKTreeNode *parent;

- (void)printDescription;

@end
