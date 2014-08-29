//
//  EKAVLTreeNode.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/29/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKAVLTreeNode.h"


@implementation EKAVLTreeNode;

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

@end
