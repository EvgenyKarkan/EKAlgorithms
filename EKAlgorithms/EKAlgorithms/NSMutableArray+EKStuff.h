//
//  NSMutableArray+EKStuff.h
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (EKStuff)

- (void)partitionArrayWithMinimalIndex:(NSInteger)min withMaximumIndex:(NSInteger)max;

- (void)mergeArrayWithMinimalIndex:(NSInteger)min withMediumIndex:(NSInteger)mid withMaximalIndex:(NSInteger)max;

- (void)siftDownArrayWithStart:(NSInteger)startIndex end:(NSInteger)endIndex;

- (void)heapifyArrayWithSize:(NSInteger)size;

@end
