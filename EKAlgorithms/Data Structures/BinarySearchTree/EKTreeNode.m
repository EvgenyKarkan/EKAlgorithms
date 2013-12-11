//
//  EKTreeNode.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKTreeNode.h"

@implementation EKTreeNode

- (void)printDescription
{
    NSLog(@"%@", self.object);
    
	if (self.leftChild) {
        NSLog(@"Left child of %@ will be the -->", self.object);
		[self.leftChild printDescription];;
	}
    
	if (self.rightChild) {
        NSLog(@"Right child of %@ will be the -->", self.object);
		[self.rightChild printDescription];
	}
}

@end
