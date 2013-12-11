//
//  EKGraph.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKGraph.h"
#import "EKVertex.h"
#import "EKStack.h"
#import "EKQueue.h"

@interface EKGraph ()

@property (nonatomic, strong) EKVertex *firstVertex;

@end

@implementation EKGraph;

- (instancetype)initWithStartVertex:(id)startVertex
{
    self = [super init];
    if (self) {
        self.firstVertex = startVertex;
    }
    return self;
}

#pragma mark - DFS

- (void)depthFirstSearch
{
	NSAssert([self.vertices count] > 0, @"No any vertex in graph");
    
	self.firstVertex.label = @"Start vertex";
	self.firstVertex.wasVisited = YES;
	[self displayVisitedVertex:self.firstVertex];
    
	EKStack *stack = [[EKStack alloc] init];
	[stack push:self.firstVertex];
    
	while (![stack isEmpty]) {
		EKVertex *lastVertex = [stack peek];
		BOOL isAddNewVertex = NO;
        
		for (EKVertex *adjacentVertex in lastVertex.adjacentVertices) {
			if (!adjacentVertex.wasVisited) {
				[stack push:adjacentVertex];
				adjacentVertex.wasVisited = YES;
				isAddNewVertex = YES;
				[self displayVisitedVertex:adjacentVertex];
				break;
			}
		}
		if (!isAddNewVertex) {
			[stack popLastObject];
		}
	}
    
	[self clearVisitHistory];
}

- (void)displayVisitedVertex:(EKVertex *)visitedVertex
{
    NSLog(@"%@ - was visited", visitedVertex.label);
}

#pragma mark - BFS

- (void)breadthFirstSearch
{
	NSAssert([self.vertices count] > 0, @"No any vertex in graph");
    
	self.firstVertex.label = @"Start vertex";
	self.firstVertex.wasVisited = YES;
	[self displayVisitedVertex:self.firstVertex];
    
	EKQueue *queue = [[EKQueue alloc] init];
	[queue insertObject:self.firstVertex];
    
	while (![queue isEmpty]) {
		EKVertex *foo = [queue removeFirstObject];
		for (EKVertex *adjacentVertex in foo.adjacentVertices) {
			if (!adjacentVertex.wasVisited) {
				[queue insertObject:adjacentVertex];
				adjacentVertex.wasVisited = YES;
				[self displayVisitedVertex:adjacentVertex];
			}
		}
	}
    
    [self clearVisitHistory];
}

#pragma mark - Clear visit history

- (void)clearVisitHistory
{
	for (EKVertex *vertex in self.vertices) {
		vertex.wasVisited = NO;
	}
}

@end
