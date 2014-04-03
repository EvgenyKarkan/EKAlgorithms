//
//  NSNumber+EKStuff.h
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface NSNumber (EKStuff)

+ (NSArray *)primeNumbersFromSieveEratosthenesWithMaxNumber:(NSUInteger)maxNumber;
- (NSUInteger)greatestCommonDivisorWithNumber:(NSUInteger)secondNumber;
- (NSUInteger)leastCommonMultipleWithNumber:(NSUInteger)secondNumber;
- (NSUInteger)factorial;
+ (NSMutableArray *)fibonacciNumbersUpToNumber:(NSUInteger)number;
+ (NSNumber *)fibonacciAtIndex:(NSUInteger)index;
+ (long long int)recursiveFibonacci:(NSUInteger)index;
+ (unsigned long long)fibonacciWithLongLong:(int)index;
+ (NSDecimalNumber *)fibonacciWithDecimal:(int)index;
- (NSUInteger)sumOfDigits;
+ (NSUInteger)decimalNumberFromBinary:(NSUInteger)binary;
+ (NSUInteger)binaryNumberFromDecimal:(NSUInteger)decimal;
+ (NSInteger)fastExpForNumber:(NSInteger)number withPower:(NSInteger)power;
- (NSUInteger)reverseNumber;
- (BOOL)isEven;
- (BOOL)isLeapGivenYear;
- (BOOL)isArmstrongNumber;
- (BOOL)isPrime;
+ (NSUInteger)nthPrime:(NSUInteger)n;
+ (void)swapValueOfIntPointer:(NSInteger *)xPointer withValueOfIntPointer:(NSInteger *)yPointer;
- (CGFloat)squareRoot;
- (id)convertedNumberWithBase:(int)base;
- (CGFloat)fastInverseSquareRoot;

/**
 Josephus Problem
 http://en.wikipedia.org/wiki/Josephus_problem

 It is naive implementation of "killer iterator" which beheads elements using step of K, so the survivors (their number is always less than K) constitute a result.
 
 There is obviously a much more efficient solution, but this is another story.
 
 @return Returns index set with indexes of survivor elements.
 */
+ (NSIndexSet *)JosephusProblem:(NSUInteger)N K:(NSUInteger)K;

@end
