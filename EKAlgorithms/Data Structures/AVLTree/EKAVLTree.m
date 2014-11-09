//
//  EKAVLTree.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/29/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKAVLTree.h"
#import "EKAVLTreeNode.h"

@implementation EKAVLTree

- (instancetype)initWithObject:(NSObject *)obj compareSelector:(SEL)selector
{
    if (self = [super init]) {
        _root                     = [[EKAVLTreeNode alloc] init];
        self.root.object          = obj;
        self.root.height          = 0;
        self.root.compareSelector = selector;
    }
    
    return self;
}

- (void)insertObject:(NSObject *)newObject
{
    [self insertObject:newObject AtNode:self.root];
}

- (EKAVLTreeNode *)insertObject:(NSObject *)newObject AtNode:(EKAVLTreeNode *)T
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (!T) {
        T                 = [[EKAVLTreeNode alloc] init];
        T.object          = newObject;
        T.leftChild       = T.rightChild = nil;
        T.compareSelector = self.root.compareSelector;
        T.height          = 0;
    } else {
        NSComparisonResult result = (NSComparisonResult)[newObject performSelector : T.compareSelector withObject : T.object];
        if (result < 0) {
            T.leftChild = [self insertObject:newObject AtNode:T.leftChild];
            if ([EKAVLTree heightOfNode:T.leftChild] - [EKAVLTree heightOfNode:T.rightChild] == 2) {
                if ((NSComparisonResult)[newObject performSelector : T.leftChild.compareSelector withObject : T.leftChild.object]) {
                    T = [EKAVLTree singleRotateWithLeft:T];
                } else {
                    T = [EKAVLTree doubleRotateWithLeft:T];
                }
            }
        } else if (result > 0) {
            T.rightChild = [self insertObject:newObject AtNode:T.rightChild];
            if ([EKAVLTree heightOfNode:T.rightChild] - [EKAVLTree heightOfNode:T.leftChild] == 2) {
                if ((NSComparisonResult)[newObject performSelector : T.rightChild.compareSelector withObject : T.rightChild.object]) {
                    T = [EKAVLTree singleRotateWithRight:T];
                } else {
                    T = [EKAVLTree doubleRotateWithRight:T];
                }
            }
        }
        T.height = MAX([EKAVLTree heightOfNode:T.leftChild], [EKAVLTree heightOfNode:T.rightChild])+1;
    }
#pragma clang diagnostic pop
    return T;
}

- (void)printDescription
{
    [self.root printDescription];
}

- (EKAVLTreeNode *)find:(NSObject *)obj
{
    EKAVLTreeNode *currentNode = self.root;
    while (YES) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSComparisonResult result = (NSComparisonResult)[obj performSelector : currentNode.compareSelector withObject : currentNode.object];
#pragma clang diagnostic pop
        if (result > 0) {
            if (currentNode.rightChild) {
                currentNode = currentNode.rightChild;
            } else
                return nil;
        } else if (result < 0) {
            if (currentNode.leftChild) {
                currentNode = currentNode.leftChild;
            } else
                return nil;
        } else {
            break;
        }
    }
    return currentNode;
}

- (void)deleteObject:(NSObject *)object
{
    [self deleteObject:object AtNode:self.root];
}

- (EKAVLTreeNode *)deleteObject:(NSObject *)object AtNode:(EKAVLTreeNode *)T
{
    if (!T) {
        return nil;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSComparisonResult result = (NSComparisonResult)[object performSelector : T.compareSelector withObject : T.object];
#pragma clang diagnostic pop
    if (result == 0) {
        if (T.rightChild == nil) {
            EKAVLTreeNode *temp = T;
            T = T.leftChild;
            temp = nil;
        } else {
            EKAVLTreeNode *temp = T.rightChild;
            while (temp.leftChild != nil) {
                temp = temp.leftChild;
            }
            
            T.object     = [temp.object copy];
            T.rightChild = [self deleteObject:temp.object AtNode:T.rightChild];
            T.height     = MAX([EKAVLTree heightOfNode:T.leftChild], [EKAVLTree heightOfNode:T.rightChild])+1;
        }
        return T;
    } else if (result < 0) {
        T.leftChild = [self deleteObject:object AtNode:T.leftChild];
    } else {
        T.rightChild = [self deleteObject:object AtNode:T.rightChild];
    }
    
    T.height = MAX([EKAVLTree heightOfNode:T.leftChild], [EKAVLTree heightOfNode:T.rightChild])+1;
    
    if (T.leftChild != nil) {
        T.leftChild = [EKAVLTree rotateSingleNode:T.leftChild];
    }
    if (T.rightChild != nil) {
        T.rightChild = [EKAVLTree rotateSingleNode:T.rightChild];
    }
    T = [EKAVLTree rotateSingleNode:T];
    return T;
}

+ (NSInteger)heightOfNode:(EKAVLTreeNode *)node
{
    if (!node) {
        return -1;
    }
    else {
       return node.height;
    }
}

#pragma mark - AVL Rotation

+ (EKAVLTreeNode *)singleRotateWithLeft:(EKAVLTreeNode *)K2
{
    EKAVLTreeNode *K1;
    
    K1            = K2.leftChild;
    K2.leftChild  = K1.rightChild;
    K1.rightChild = K2;
    
    K2.height = MAX([EKAVLTree heightOfNode:K2.leftChild], [EKAVLTree heightOfNode:K2.rightChild])+1;
    K1.height = MAX([EKAVLTree heightOfNode:K1.leftChild], [EKAVLTree heightOfNode:K1.rightChild])+1;
    
    return K1;
}

+ (EKAVLTreeNode *)singleRotateWithRight:(EKAVLTreeNode *)K2
{
    EKAVLTreeNode *K1;
    
    K1            = K2.rightChild;
    K2.rightChild = K1.leftChild;
    K1.leftChild  = K2;
    
    K2.height = MAX([EKAVLTree heightOfNode:K2.leftChild], [EKAVLTree heightOfNode:K2.rightChild])+1;
    K1.height = MAX([EKAVLTree heightOfNode:K1.leftChild], [EKAVLTree heightOfNode:K1.rightChild])+1;
    
    return K1;
}

+ (EKAVLTreeNode *)doubleRotateWithLeft:(EKAVLTreeNode *)K3
{
    K3.leftChild = [EKAVLTree singleRotateWithRight:K3.leftChild];
    return [EKAVLTree singleRotateWithLeft:K3];
}

+ (EKAVLTreeNode *)doubleRotateWithRight:(EKAVLTreeNode *)K3
{
    K3.rightChild = [EKAVLTree singleRotateWithLeft:K3.rightChild];
    return [EKAVLTree singleRotateWithRight:K3];
}

+ (EKAVLTreeNode *)rotateSingleNode:(EKAVLTreeNode *)T
{
    if ([EKAVLTree heightOfNode:T.leftChild] - [EKAVLTree heightOfNode:T.rightChild] == 2) {
        if ([EKAVLTree heightOfNode:T.leftChild.leftChild] >= [EKAVLTree heightOfNode:T.leftChild.rightChild]) {
            T = [EKAVLTree singleRotateWithLeft:T];
        } else {
            T = [EKAVLTree doubleRotateWithLeft:T];
        }
    }
    if ([EKAVLTree heightOfNode:T.rightChild] - [EKAVLTree heightOfNode:T.leftChild] == 2) {
        if ([EKAVLTree heightOfNode:T.rightChild.rightChild] >= [EKAVLTree heightOfNode:T.rightChild.leftChild]) {
            T = [EKAVLTree singleRotateWithRight:T];
        } else {
            T = [EKAVLTree doubleRotateWithRight:T];
        }
    }
    return T;
}

@end
