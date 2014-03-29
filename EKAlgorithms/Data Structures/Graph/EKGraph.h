//
//  EKGraph.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface EKGraph : NSObject

@property (nonatomic, strong) NSMutableArray *vertices;

- (instancetype)initWithStartVertex:(id)startVertex;
- (void)depthFirstSearch;
- (void)breadthFirstSearch;
- (BOOL)isUndirectedGraph;

@end
