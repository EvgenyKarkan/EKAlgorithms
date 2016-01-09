//
//  EKGraph.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

@class EKVertex;

@interface EKGraph : NSObject

@property (nonatomic, strong) NSMutableArray *vertices;

- (instancetype)initWithStartVertex:(id)startVertex;
- (void)depthFirstSearch;
- (void)depthFirstSearchRecursive:(EKVertex *)vertex;
- (void)breadthFirstSearch;
- (BOOL)isUndirectedGraph;
- (void)clearVisitHistory;
- (void)primMST:(id)startVertex;
- (void)kruskalMST;
- (void)dijkstraSPTFrom:(id)sourceVertex To:(id)targetVertex;
- (void)topSort;

@end
