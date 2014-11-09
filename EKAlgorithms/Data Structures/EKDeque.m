//
//  EKDeque.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKDeque.h"

@interface EKDeque ()

@property (nonatomic, strong) NSMutableArray *dequeArray;

@end


@implementation EKDeque;

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _dequeArray = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Public API

- (void)insertObjectToBack:(id)object
{
    if (object != nil) {
        [self.dequeArray addObject:object];
    }
    else {
        NSAssert(object != nil, @"You can't push nil object to deque");
    }
}

- (void)insertObjectToFront:(id)object
{
    if (object != nil) {
        [self.dequeArray insertObject:object atIndex:0];
    }
    else {
        NSAssert(object != nil, @"You can't push nil object to deque");
    }
}

- (id)removeFirstObject
{
    if ([self.dequeArray count] > 0) {
        id object = [self peekFirstObject];
        [self.dequeArray removeObjectAtIndex:0];
        
        return object;
    }
    
    return nil;
}

- (id)removeLastObject
{
    id object = [self peekLastObject];
    [self.dequeArray removeLastObject];
    
    return object;
}

- (id)peekFirstObject
{
    if ([self.dequeArray count] > 0) {
        return (self.dequeArray)[0];
    }
    
    return nil;
}

- (id)peekLastObject
{
    if ([self.dequeArray count] > 0) {
        return [self.dequeArray lastObject];
    }
    
    return nil;
}

- (BOOL)isEmpty
{
    return [self.dequeArray count] == 0;
}

- (void)clear
{
    [self.dequeArray removeAllObjects];
}

- (NSArray *)allObjectsFromDeque
{
    NSMutableArray *buffer = [@[] mutableCopy];
    
    for (id object in self.dequeArray) {
        [buffer addObject:object];
    }
    
    return [buffer copy];
}

@end
