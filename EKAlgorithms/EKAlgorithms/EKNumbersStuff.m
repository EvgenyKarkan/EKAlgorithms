//
//  ENumbers.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 16.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKNumbersStuff.h"


@implementation EKNumbersStuff;

#pragma mark - Sieve of Eratosthenes

+ (NSArray *)primeNumbersFromSieveEratosthenesWithMaxNumber:(NSUInteger)maxNumber
{
	NSMutableArray *resultArray = [@[] mutableCopy];
    
	for (NSUInteger i = 0; i < maxNumber; i++) {
		resultArray[i] = [NSNumber numberWithInteger:i];
	}
    
	resultArray[1] = [NSNumber numberWithInteger:0];
    
	for (NSUInteger s = 2; s < maxNumber; s++) {
		if (resultArray[s] != [NSNumber numberWithInteger:0]) {
			for (NSUInteger j = s * 2; j < maxNumber; j += s) {
				resultArray[j] = [NSNumber numberWithInteger:0];
			}
		}
	}
	[resultArray removeObjectIdenticalTo:[NSNumber numberWithInteger:0]];
    
	return [resultArray copy];
}

#pragma mark - GCD

+ (NSUInteger)greatestCommonDivisorWithFirstNumber:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber
{
	NSUInteger c;
    
	while (firstNumber != 0) {
		c = firstNumber;
		firstNumber =  secondNumber % firstNumber;
		secondNumber = c;
	}
    
	return secondNumber;
}

#pragma mark - LCM

+ (NSUInteger)leastCommonMultipleWithFirstNumber:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber
{
	return firstNumber * secondNumber  / [self greatestCommonDivisorWithFirstNumber:firstNumber secondNumber:secondNumber];
}

#pragma mark - Factorial

+ (NSUInteger)factorialForNumber:(NSUInteger)number
{
	NSUInteger factorial = 1;
    
	for (NSUInteger i = 1; i <= number; i++) {
		factorial = factorial * i;
	}
    
	return factorial;
}

#pragma mark - Fibonacci

+ (NSMutableArray *)fibonacciNumbersUpToNumber:(NSUInteger)number
{
	NSMutableArray *resultArray = [@[] mutableCopy];
    
	resultArray[0] = [NSNumber numberWithInteger:0];
	resultArray[1] = [NSNumber numberWithInteger:1];
    
	for (NSUInteger i = 2; i < number; i++) {
		NSNumber *foo = [NSNumber numberWithInteger:[resultArray[i - 2] integerValue] + [resultArray[i - 1] integerValue]];
		resultArray[i] = foo;
	}
    
	return resultArray;
}

@end
