//
//  EKTree.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKTreeNode.h"

@interface EKTree : NSObject

@property (nonatomic, strong) EKTreeNode *root;

- (instancetype)initWithObject:(NSObject *)object;
- (void)insertNode:(EKTreeNode *)node leftSibling:(EKTreeNode *)leftSibling parent:(EKTreeNode *)parent;
- (void)printDescription;

@end
