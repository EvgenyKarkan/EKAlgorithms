//
//  EKTreeNode.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKTreeNode : NSObject

@property (nonatomic, strong) NSObject *object;
@property (nonatomic, strong) EKTreeNode *leftChild;
@property (nonatomic, strong) EKTreeNode *rightChild;
@property (nonatomic, assign) SEL compareSelector;

- (void)printDescription;

@end
