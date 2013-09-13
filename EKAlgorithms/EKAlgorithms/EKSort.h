//
//  EKSort.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKSort : NSObject

+ (NSMutableArray *)bubbleSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;

+ (NSMutableArray *)shellSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;

+ (NSMutableArray *)mergeSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;

+ (NSMutableArray *)quickSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
										   withLeftId:(NSInteger)left
										  withRightId:(NSInteger)right;

@end
