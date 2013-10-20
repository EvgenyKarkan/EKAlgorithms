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

@end
