//
//  EKGraph.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSDictionary+EKStuff.h"
#import "NSNumber+EKStuff.h"
#import "EKGraph.h"
#import "EKVertex.h"
#import "EKEdge.h"
#import "EKStack.h"
#import "EKQueue.h"

#if TARGET_OS_IPHONE
#import "NSNumber+EKComparisonForIOS.h"
#import "NSObject+EKComparisonForIOS.h"
#endif


@interface EKGraph ()

@property (nonatomic, strong) EKVertex            *firstVertex;
@property (nonatomic, strong) NSMutableDictionary *indegree;

@end


@implementation EKGraph;

@synthesize indegree = _indegree;

- (instancetype)initWithStartVertex:(id)startVertex
{
    self = [super init];
    
    if (self) {
        _firstVertex = startVertex;
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
    EKVertex *startVertex  = start;
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
            }
            else {
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

#pragma mark - Kruskal Algorithm

- (void)kruskalMST
{
    NSMutableArray *vertices = self.vertices;
    NSMutableArray *edges    = [@[] mutableCopy];
    
    for (EKVertex *vertex in vertices) {
        for (EKEdge *edge in vertex.adjacentEdges) {
            [edges addObject:edge];
        }
    }
    
    NSUInteger forestCount = vertices.count;
    
    while (forestCount > 1) {
        EKEdge *e = [EKGraph minimumWeightUnusedEdgeInEdges:edges];
        if (e) {
            if (![self hasPathBetweenVertices:@[e.adjacentFrom, e.adjacentTo]]) {
                e.used = YES;
                [EKGraph oppositeEdge:e InEdges:edges].used = YES;
                forestCount--;
            }
            else {
                [edges removeObject:e];
                [edges removeObject:[EKGraph oppositeEdge:e InEdges:edges]];
            }
        }
    }
    
    for (EKEdge *edge in edges) {
        if (edge.used) {
            NSLog(@"%@ -- Weight:%@ --> %@", edge.adjacentFrom.label, edge.weight, edge.adjacentTo.label);
        }
    }
}

+ (EKEdge *)minimumWeightUnusedEdgeInEdges:(NSArray *)edges
{
    EKEdge *minEdge;
    
    for (EKEdge *edge in edges) {
        if (!edge.used) {
            if (minEdge) {
                if ([minEdge.weight isGreaterThan:edge.weight]) {
                    minEdge = edge;
                }
            }
            else {
                minEdge = edge;
            }
        }
    }
    
    return minEdge;
}

- (BOOL)hasPathBetweenVertices:(NSArray *)vertices
{
    NSAssert(vertices.count == 2, @"Vertices Count must be two!");
    NSAssert([vertices firstObject] != [vertices lastObject], @"Vertices must be different!");
    
    EKQueue *queue = [[EKQueue alloc] init];
    [self clearVisitHistory];
    
    EKVertex *startVertex  = [vertices firstObject];
    startVertex.wasVisited = YES;
    
    for (EKEdge *edge in startVertex.adjacentEdges) {
        if (edge.used) {
            [queue insertObject:edge.adjacentTo];
        }
    }
    
    while (![queue isEmpty]) {
        EKVertex *peekVertex  = [queue removeFirstObject];
        peekVertex.wasVisited = YES;
        
        if (peekVertex == [vertices lastObject]) {
            return YES;
        }
        else {
            for (EKEdge *edge in peekVertex.adjacentEdges) {
                if (edge.used && !edge.adjacentTo.wasVisited) {
                    [queue insertObject:edge.adjacentTo];
                }
            }
        }
    }
    
    return NO;
}

+ (EKEdge *)oppositeEdge:(EKEdge *)edge InEdges:(NSArray *)edges
{
    EKVertex *startVertex = edge.adjacentFrom;
    EKVertex *endVertex   = edge.adjacentTo;
    
    for (EKEdge *e in edges) {
        if (e.adjacentFrom == endVertex && e.adjacentTo == startVertex && [e.weight isEqualTo:edge.weight]) {
            return e;
        }
    }
    return nil;
}

#pragma mark - Dijkstra Algorithm

- (void)dijkstraSPTFrom:(id)source To:(id)target
{
    EKVertex *sourceVertex = source, *targetVertex = target;
    
    NSMutableDictionary *dist     = [@{} mutableCopy];
    NSMutableDictionary *previous = [@{} mutableCopy];
    NSMutableArray *Q             = self.vertices;
    
    for (EKVertex *vertex in Q) {
        [dist setValue:@INT_MAX forKey:vertex.label];
        [previous setValue:[NSNull null] forKey:vertex.label];
    }
    [dist setValue:@0 forKey:sourceVertex.label];
    
    while (Q.count > [self visitedVertices].count) {
        EKVertex *u = [EKGraph hasMinimumDistance:dist InVertices:Q];
        if (u == targetVertex) {
            break;
        }
        if ([[dist valueForKey:u.label] isEqualTo:@INT_MAX]) {
            break;
        }
        for (EKEdge *edge in u.adjacentEdges) {
            EKVertex *v   = edge.adjacentTo;
            NSNumber *alt = [NSNumber sumOfNumbers:@[[dist valueForKey:u.label], edge.weight]];
            
            if ([alt isLessThan:[dist valueForKey:v.label]]) {
                [dist setValue:alt forKey:v.label];
                [previous setValue:u forKey:v.label];
            }
        }
        u.wasVisited = YES;
    }
    
    for (NSString *label in previous) {
        if (![[previous valueForKey:label] isMemberOfClass:[NSNull class]]) {
            NSLog(@"%@ previous node --> %@", label, ((EKVertex *)[previous valueForKey:label]).label);
        }
        else {
            NSLog(@"%@ has no previous node", label);
        }
    }
}

+ (EKVertex *)hasMinimumDistance:(NSDictionary *)dist InVertices:(NSArray *)Q
{
    NSNumber *minDist = nil;
    NSUInteger index  = 0;
    
    for (EKVertex *vertex in Q) {
        if (!vertex.wasVisited) {
            NSString *label = vertex.label;
            if (!minDist) {
                minDist = [dist valueForKey:label];
                index   = [Q indexOfObject:vertex];
            }
            else {
                if ([minDist isGreaterThan:[dist valueForKey:label]]) {
                    minDist = [dist valueForKey:label];
                    index   = [Q indexOfObject:vertex];
                }
            }
        }
    }
    
    return Q[index];
}

#pragma mark - Topsort

- (void)topSort
{
    NSMutableArray *topNum   = [@[] mutableCopy];
    EKQueue *queue           = [[EKQueue alloc] init];
    NSMutableArray *vertices = self.vertices;
    
    for (NSUInteger i = 0; i < vertices.count; i++) {
        EKVertex *vertex = [self findNewVertexOfIndegreeZero:vertices];
        if (vertex) {
            [queue insertObject:vertex];
        }
    }
    NSAssert(![queue isEmpty], @"Graph has a cycle!");
    
    while (![queue isEmpty]) {
        EKVertex *V = [queue removeFirstObject];
        [topNum addObject:V];
        
        for (EKEdge *edge in V.adjacentEdges) {
            [_indegree selfDecreaseValueForKey:edge.adjacentTo.label];
            if ([[_indegree valueForKey:edge.adjacentTo.label] isEqualToNumber:@0]) {
                [queue insertObject:edge.adjacentTo];
            }
        }
    }
    
    for (EKVertex *vertex in topNum) {
        NSLog(@"Topsort %lu --> %@", (unsigned long)[topNum indexOfObject:vertex], vertex.label);
    }
}

- (EKVertex *)findNewVertexOfIndegreeZero:(NSArray *)vertices
{
    if (!_indegree) {
        // Graph should not change at runtime
        _indegree = [@{} mutableCopy];
        [self clearVisitHistory];
        
        for (EKVertex *vertex in vertices) {
            [_indegree setValue:@0 forKey:vertex.label];
        }
        
        for (EKVertex *vertex in vertices) {
            for (EKEdge *edge in vertex.adjacentEdges) {
                EKVertex *adjTo = edge.adjacentTo;
                [_indegree setValue:@(([[_indegree valueForKey:adjTo.label] integerValue])+1) forKey:adjTo.label];
            }
        }
    }
    
    for (EKVertex *vertex in vertices) {
        if ([[_indegree valueForKey:vertex.label] isEqualToNumber:@0] && !vertex.wasVisited) {
            vertex.wasVisited = YES;
            return vertex;
        }
    }
    return nil;
}

#pragma mark - DFS

- (void)depthFirstSearch
{
    NSAssert([self.vertices count] > 0, @"No any vertex in graph");
    
    self.firstVertex.label      = @"Start vertex";
    self.firstVertex.wasVisited = YES;
    [self displayVisitedVertex:self.firstVertex];
    
    EKStack *stack = [[EKStack alloc] init];
    [stack push:self.firstVertex];
    
    while (![stack isEmpty]) {
        EKVertex *lastVertex = [stack peek];
        BOOL isAddNewVertex  = NO;
        
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
    
    self.firstVertex.label      = @"Start vertex";
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
        for (EKEdge *edge in vertex.adjacentEdges) {
            edge.used = NO;
        }
        vertex.wasVisited = NO;
    }
}

@end
