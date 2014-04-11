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
- (CFNumberType)numberType;
+ (NSNumber *)sumOfNumbers:(NSArray *)numbers;

@end
