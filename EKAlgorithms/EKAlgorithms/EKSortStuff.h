//
//  EKSort.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKSortStuff : NSObject

+ (NSMutableArray *)bubbleSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;
+ (NSMutableArray *)shellSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;
+ (NSMutableArray *)mergeSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;
+ (NSMutableArray *)quickSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray
                                        withLeftIndex:(NSInteger)left
                                       withRightIndex:(NSInteger)right;
+ (NSMutableArray *)insertionSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;
+ (NSMutableArray *)selectionSortedArrayWithUnsortedArray:(NSMutableArray *)unsortedArray;

@end
