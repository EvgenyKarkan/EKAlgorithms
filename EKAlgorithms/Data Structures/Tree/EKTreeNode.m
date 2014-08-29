//
//  EKTreeNode.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKTreeNode.h"


@implementation EKTreeNode;

- (void)printDescription
{
    NSLog(@"%@", self.object);
    
    if (self.child) {
        NSLog(@"First child of %@ will be the -->", self.object);
        [self.child printDescription];
    }
    
    if (self.sibling) {
        NSLog(@"Next sibling of %@ will be the -->", self.object);
        [self.sibling printDescription];
    }
}

@end
