//
//  EKBSTree.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKTreeNode.h"

@interface EKBSTree : NSObject

@property (nonatomic, strong) EKTreeNode *root;

- (instancetype)initWithObject:(NSObject *)object compareSelector:(SEL)selector;
- (BOOL)find:(NSObject *)object;
- (void)insertObject:(NSObject *)newObject;
- (void)deleteObject:(NSObject *)object;

@end
