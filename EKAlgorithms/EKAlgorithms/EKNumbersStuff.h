//
//  ENumbers.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 16.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKNumbersStuff : NSObject

+ (NSArray *)primeNumbersFromSieveEratosthenesWithMaxNumber:(NSUInteger)maxNumber;
+ (NSUInteger)greatestCommonDivisorWithFirstNumber:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber;
+ (NSUInteger)leastCommonMultipleWithFirstNumber:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber;
+ (NSUInteger)factorialForNumber:(NSUInteger)number;
+ (NSMutableArray *)fibonacciNumbersUpToNumber:(NSUInteger)number;
+ (NSUInteger)sumOfDigitsOfNumber:(NSUInteger)number;
+ (NSUInteger)decimalNumberFromBinary:(NSUInteger)binary;
+ (NSUInteger)binaryNumberFromDecimal:(NSUInteger)decimal;
+ (NSInteger)fastExpForNumber:(NSInteger)number withPower:(NSInteger)power;
+ (NSUInteger)reverseNumberWithNumber:(NSUInteger)numberToReverse;
+ (BOOL)isEvenNumber:(NSUInteger)number;
+ (BOOL)isLeapGivenYear:(NSUInteger)number;

@end
