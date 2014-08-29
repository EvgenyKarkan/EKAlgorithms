//
//  EKTreeNode.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKBTreeNode.h"


@implementation EKBTreeNode;

- (void)printDescription
{
    NSLog(@"%@", self.object);
    
    if (self.leftChild) {
        NSLog(@"Left child of %@ will be the -->", self.object);
        [self.leftChild printDescription];
    }
    
    if (self.rightChild) {
        NSLog(@"Right child of %@ will be the -->", self.object);
        [self.rightChild printDescription];
    }
}

- (BOOL)isLeftChildOfParent
{
    return self.parent.leftChild == self ? YES : NO;
}

@end
