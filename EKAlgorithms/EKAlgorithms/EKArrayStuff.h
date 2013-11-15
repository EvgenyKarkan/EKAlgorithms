//
//  EKArray.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKArrayStuff : NSObject

+ (NSUInteger)indexOfMaximumElementInArray:(NSArray *)array;
+ (NSString *)longestStringInArray:(NSMutableArray *)array;
+ (NSString *)shortestStringInArray:(NSMutableArray *)array;
+ (NSArray *)reversedArrayWithArray:(NSArray *)arrayToReverse;
+ (NSArray *)intersectionOfArray:(NSArray *)firstArray withArray:(NSArray *)secondArray;
+ (NSArray *)unionWithoutDuplicatesOfArray:(NSArray *)firstArray withArray:(NSArray *)secondArray;
+ (BOOL)findDuplicatesInArray:(NSArray *)givenArray;
+ (NSArray *)randomObjectsWithArraySize:(NSUInteger)arraySize maxRandomValue:(NSUInteger)maxValue uniqueObjects:(BOOL)unique;

@end
