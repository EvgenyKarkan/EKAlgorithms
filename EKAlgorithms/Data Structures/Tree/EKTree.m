//
//  EKTree.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKTree.h"

@implementation EKTree

- (instancetype)initWithObject:(NSObject *)object
{
    if (self = [super init]) {
        self.root = [[EKTreeNode alloc] init];
        self.root.object = object;
        self.root.parent = nil;
    }
    
    return self;
}

- (void)insertNode:(EKTreeNode *)node leftSibling:(EKTreeNode *)leftSibling parent:(EKTreeNode *)parent
{
    node.parent = parent;
    if (leftSibling == nil) {
        parent.child = node;
    } else {
        leftSibling.sibling = node;
    }
}

- (void)printDescription
{
    [self.root printDescription];
}


@end
