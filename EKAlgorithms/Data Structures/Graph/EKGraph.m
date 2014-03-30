//
//  EKGraph.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKGraph.h"
#import "EKVertex.h"
#import "EKEdge.h"
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

- (BOOL)isUndirectedGraph
{
    NSAssert([self.vertices count] > 0, @"No any vertex in graph");
    
    for (EKVertex *vertex in self.vertices) {
        if (![self hasOppositeEdge:vertex]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)hasOppositeEdge:(EKVertex *)vertex
{
    for (EKEdge *eachEdge in vertex.adjacentEdges) {
        for (EKEdge *edge in eachEdge.adjacentTo.adjacentEdges) {
            if (edge.adjacentTo == vertex) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - Prim Algorithm
- (void)primMST:(id)start
{
    EKVertex *startVertex = start;
    NSMutableArray *parent = [@[] mutableCopy];
    [self clearVisitHistory];
    
    startVertex.wasVisited = YES;
    while ([self visitedVertices].count != self.vertices.count) {
        EKEdge *minimumEdge = [EKGraph minimumWeightEdgeInVertices:[self visitedVertices]];
        if (minimumEdge) {
            [parent addObject:minimumEdge];
        }
        minimumEdge.adjacentTo.wasVisited = YES;
    }
    for (EKEdge *edge in parent) {
        NSLog(@"From %@, To %@, Weight %@", edge.adjacentFrom.label, edge.adjacentTo.label, edge.weight);
    }
}

+ (EKEdge *)minimumWeightEdgeInVertices:(NSArray *)vertices
{
    EKEdge *minimumEdge = nil;
    for (EKVertex *vertex in vertices) {
        for (EKEdge *edge in vertex.adjacentEdges) {
            if (!minimumEdge && !edge.adjacentTo.wasVisited) {
                minimumEdge = edge;
            } else {
                if ([minimumEdge.weight isGreaterThan:edge.weight] && !edge.adjacentTo.wasVisited) {
                    minimumEdge = edge;
                }
            }
        }
    }
    return minimumEdge;
}

- (NSArray *)visitedVertices
{
    NSMutableArray *visited = [@[] mutableCopy];
    for (EKVertex *vertex in self.vertices) {
        if (vertex.wasVisited) {
            [visited addObject:vertex];
        }
    }
    return visited;
}

#pragma mark - Dijkstra Algorithm

- (void)dijkstraSPTFrom:(id)source To:(id)target
{
    EKVertex *sourceVertex = source, *targetVertex = target;
    NSMutableDictionary *dist = [@{} mutableCopy];
    NSMutableDictionary *previous = [@{} mutableCopy];
    for (EKVertex *vertex in self.vertices) {
        [dist setValue:@INT_MAX forKey:vertex.label];
        [previous setValue:[NSNull null] forKey:vertex.label];
    }
    [dist setValue:@0 forKey:sourceVertex.label];
    NSMutableArray *Q = [self.vertices mutableCopy];
    while ([Q count] > 0) {
        EKVertex *u = [EKGraph hasMinimumDistance:dist InVertices:Q];
        if (u == targetVertex) {
            break;
        }
        if ([[dist valueForKey:u.label] isEqualTo:@INT_MAX]) {
            break;
        }
        for (EKEdge *edge in u.adjacentEdges) {
            EKVertex *v = edge.adjacentTo;
            NSNumber *alt = [NSNumber numberWithInteger:[[dist valueForKey:u.label] integerValue] + ((NSNumber *)edge.weight).integerValue];
            if ([alt isLessThan:[dist valueForKey:v.label]]) {
                [dist setValue:alt forKey:v.label];
                [previous setValue:u forKey:v.label];
            }
        }
        [Q removeObject:u];
    }
    for (NSString *label in previous) {
        if (![[previous valueForKey:label] isMemberOfClass:[NSNull class]]) {
            NSLog(@"%@ previous node --> %@", label, ((EKVertex *)[previous valueForKey:label]).label);
        } else {
            NSLog(@"%@ has no previous node", label);
        }
    }
}

+ (EKVertex *)hasMinimumDistance:(NSDictionary *)dist InVertices:(NSArray *)Q
{
    NSNumber *minDist;
    NSUInteger index;
    for (EKVertex *vertex in Q) {
        NSString *label = vertex.label;
        if (!minDist) {
            minDist = [dist valueForKey:label];
            index = [Q indexOfObject:vertex];
        } else {
            if ([minDist isGreaterThan:[dist valueForKey:label]]) {
                minDist = [dist valueForKey:label];
                index = [Q indexOfObject:vertex];
            }
        }
    }
    return [Q objectAtIndex:index];
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
        
        for (EKEdge *adjacentEdge in lastVertex.adjacentEdges) {
            if (!adjacentEdge.adjacentTo.wasVisited) {
                [stack push:adjacentEdge.adjacentTo];
                adjacentEdge.adjacentTo.wasVisited = YES;
                isAddNewVertex = YES;
                [self displayVisitedVertex:adjacentEdge.adjacentTo];
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
        for (EKEdge *adjacentEdge in foo.adjacentEdges) {
            if (!adjacentEdge.adjacentTo.wasVisited) {
                [queue insertObject:adjacentEdge.adjacentTo];
                adjacentEdge.adjacentTo.wasVisited = YES;
                [self displayVisitedVertex:adjacentEdge.adjacentTo];
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
