//
//  EKStack.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface EKStack : NSObject

- (instancetype)initWithSize:(NSUInteger)size NS_DESIGNATED_INITIALIZER;

- (id)popLastObject;
- (void)push:(id)object;
- (id)peek;
- (NSInteger)sizeOfStack;
- (BOOL)isEmpty;
- (BOOL)isFull;
- (void)clear;
- (NSArray *)allObjectsFromStack;

@end
