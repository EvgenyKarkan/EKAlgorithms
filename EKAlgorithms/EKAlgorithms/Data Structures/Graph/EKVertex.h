//
//  EKVertex.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKVertex : NSObject

@property (nonatomic, strong) NSString *label;
@property (nonatomic, assign) BOOL wasVisited;
@property (nonatomic, strong) NSMutableSet *adjacentVertices;

@end
