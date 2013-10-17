//
//  ENumbers.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 16.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKNumbers : NSObject

+ (NSArray *)primeNumbersFromSieveEratosthenesWithMaxNumber:(NSUInteger)maxNumber;
+ (NSUInteger)greatestCommonDivisor:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber;
+ (NSUInteger)factorialForNumber:(NSUInteger)number;

@end
