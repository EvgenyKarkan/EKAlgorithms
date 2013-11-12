//
//  EKGraph.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKGraph : NSObject

@property (nonatomic, strong) NSMutableArray *vertices;

- (instancetype)initWithStartVertex:(id)startVertex;

- (void)depthFirstSearch;

    //TODO
- (void)breadthFirstSearch;

@end
