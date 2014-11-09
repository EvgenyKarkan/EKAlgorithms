//
//  EKQueue.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKQueue.h"

@interface EKQueue ()

@property (nonatomic, strong) NSMutableArray *queueArray;

@end


@implementation EKQueue;

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _queueArray = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Public API

- (void)insertObject:(id)object
{
    if (object != nil) {
        [self.queueArray addObject:object];
    }
    else {
        NSAssert(object != nil, @"You can't push nil object to deque");
    }
}

- (id)removeFirstObject
{
    if ([self.queueArray count] > 0) {
        id object = [self peek];
        [self.queueArray removeObjectAtIndex:0];
        return object;
    }
    
    return nil;
}

- (id)peek
{
    if ([self.queueArray count] > 0) {
        return (self.queueArray)[0];
    }
    
    return nil;
}

- (BOOL)isEmpty
{
    return [self.queueArray count] == 0;
}

- (void)clear
{
    [self.queueArray removeAllObjects];
}

- (NSArray *)allObjectsFromQueue
{
    NSMutableArray *buffer = [@[] mutableCopy];
    
    for (id object in self.queueArray) {
        [buffer addObject:object];
    }
    
    return [buffer copy];
}

@end
