//
//  EKStack.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKStack.h"

@interface EKStack ()

@property (nonatomic, strong) NSMutableArray *stackArray;
@property (nonatomic, assign) NSUInteger     maxStackSize;

@end


@implementation EKStack;

#pragma mark - Default init

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _stackArray = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Init with limited size of stack

- (instancetype)initWithSize:(NSUInteger)size
{
    self = [super init];
    
    if (self) {
        if (size > 0) {
            _stackArray   = [@[] mutableCopy];
            _maxStackSize = size;
        }
        else {
            NSAssert(size != 0, @"Stack size must be > 0");
        }
    }
    return self;
}

#pragma mark - Public API

- (id)popLastObject
{
    id object = [self peek];
    [self.stackArray removeLastObject];
    
    return object;
}

- (void)push:(id)object
{
    if ([self isFull] && self.maxStackSize) {
        NSLog(@"Stack is full");
        return;
    }
    
    if (object != nil) {
        [self.stackArray addObject:object];
    }
    else {
        NSAssert(object != nil, @"You can't push nil object to stack");
    }
}

- (id)peek
{
    if ([self.stackArray count] > 0) {
        return [self.stackArray lastObject];
    }
    
    return nil;
}

- (NSInteger)sizeOfStack
{
    return (NSInteger)[self.stackArray count];
}

- (BOOL)isEmpty
{
    return [self.stackArray count] == 0;
}

- (BOOL)isFull
{
    return ([self sizeOfStack] == (NSInteger)self.maxStackSize) ? YES : NO;
}

- (void)clear
{
    [self.stackArray removeAllObjects];
}

- (NSArray *)allObjectsFromStack
{
    NSMutableArray *buffer = [@[] mutableCopy];
    
    for (id object in self.stackArray) {
        [buffer addObject:object];
    }
    
    return [buffer copy];
}

@end
