//
//  NSNumber+EKStuff.m
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSNumber+EKStuff.h"


@implementation NSNumber (EKStuff);

#pragma mark - Sieve of Eratosthenes

+ (NSArray *)primeNumbersFromSieveEratosthenesWithMaxNumber:(NSUInteger)maxNumber
{
    NSMutableArray *resultArray = [@[] mutableCopy];
    
    for (NSUInteger i = 0; i < maxNumber; i++) {
        resultArray[i] = @((NSInteger)i);
    }
    
    resultArray[1] = @0;
    
    for (NSUInteger s = 2; s < maxNumber; s++) {
        if (![resultArray[s]  isEqual: @0]) {
            for (NSUInteger j = s * 2; j < maxNumber; j += s) {
                resultArray[j] = @0;
            }
        }
    }
    [resultArray removeObjectIdenticalTo:@0];
    
    return [resultArray copy];
}

#pragma mark - GCD

- (NSUInteger)greatestCommonDivisorWithNumber:(NSUInteger)secondNumber
{
    NSUInteger firstNumber = [self unsignedIntegerValue];
    NSUInteger c           = 0;
    
    while (firstNumber != 0) {
        c            = firstNumber;
        firstNumber  = secondNumber % firstNumber;
        secondNumber = c;
    }
    
    return secondNumber;
}

#pragma mark - LCM

- (NSUInteger)leastCommonMultipleWithNumber:(NSUInteger)secondNumber
{
    NSUInteger firstNumber = [self unsignedIntegerValue];
    return firstNumber * secondNumber  / [self greatestCommonDivisorWithNumber:secondNumber];
}

#pragma mark - Factorial

- (NSUInteger)factorial
{
    NSUInteger factorial = 1;
    
    for (NSUInteger i = 1; i <= [self unsignedIntegerValue]; i++) {
        factorial = factorial * i;
    }
    
    return factorial;
}

#pragma mark - Fibonacci

/*
 Original implementation does only get Fibonaccis up to the 92nd.
 */
+ (NSMutableArray *)fibonacciNumbersUpToNumber:(NSUInteger)number
{
    NSMutableArray *resultArray = [@[] mutableCopy];
    
    resultArray[0] = @0;
    resultArray[1] = @1;
    
    for (NSUInteger i = 2; i < number; i++) {
        NSNumber *foo  = @([resultArray[i - 2] integerValue] + [resultArray[i - 1] integerValue]);
        resultArray[i] = foo;
    }
    
    return resultArray;
}

/*
 Very slow recursive Fibonacci alogrith.
 */
+ (long long int)recursiveFibonacci:(NSUInteger)index
{
    if (index == 0) {
        return (long long int)0;
    }
    else if (index == 1) {
        return (long long int)1;
    }
    else {
        return [NSNumber recursiveFibonacci:index - 2] + [NSNumber recursiveFibonacci:index - 1];
    }
}

/*
 Very fast Fibonacci alogrithm. Uses unsigned long long to store numbers up to 
 2^64 = 1.8446744e+19 = 18446744073709551615. => 92 is the last index that should
 work with unsigned long long.
 */
+ (unsigned long long)fibonacciWithLongLong:(int)index
{
        // this does not work because "last" can't hold a number larger than ULLONG_MAX...
    if (index > 93) {
        NSLog(@"Fibonacci at index %i would be too long for ULLONG", index);
    }
    
    unsigned long long beforeLast = 0, last = 1;
    
    while (index > 0) {
        last += beforeLast;
        beforeLast = last - beforeLast;
        --index;
    }
    
    if (index == 0) {
        return beforeLast;
    }
    
    return last;
}

/*
 This one uses NSDecimalNumber and is correct until index 185.
 */
+ (NSDecimalNumber *)fibonacciWithDecimal:(int)index
{
    NSDecimalNumber *beforeLast = nil, *last = nil;
    beforeLast = [NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO];
    last       = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:NO];
    
    while (index > 0) {
        last       = [last decimalNumberByAdding:beforeLast];
        beforeLast = [last decimalNumberBySubtracting:beforeLast];
        --index;
    }
    
    if (index == 0) {
        return beforeLast;
    }
    
    return last;
}

+ (NSNumber *)fibonacciAtIndex:(NSUInteger)index
{
    NSArray *array = [NSNumber fibonacciNumbersUpToNumber:index + 1];
    return array[index];
}

#pragma mark - Sum of digits of a number

- (NSUInteger)sumOfDigits
{
    NSUInteger number = [self unsignedIntegerValue];
    NSUInteger sum    = 0;
    
    while (number != 0) {
        sum    = sum + number % 10;
        number = number / 10;
    }
    
    return sum;
}

#pragma mark - Binary to decimal

+ (NSUInteger)decimalNumberFromBinary:(NSUInteger)binary
{
    NSUInteger decimalNumber = 0, j = 1, remainder = 0;
    
    while (binary != 0) {
        remainder     = binary % 10;
        decimalNumber = decimalNumber + remainder * j;
        j             = j * 2;
        binary        = binary / 10;
    }
    
    return decimalNumber;
}

#pragma mark - Decimal to binary

+ (NSUInteger)binaryNumberFromDecimal:(NSUInteger)decimal
{
    NSUInteger quotient = 0;
    int binaryNumber[100], i = 1;
    quotient = decimal;
    
    while (quotient != 0) {
        binaryNumber[i++] = quotient % 2;
        quotient          = quotient / 2;
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (NSUInteger j = i - 1; j > 0; j--) {
        [result appendString:[NSString stringWithFormat:@"%d", binaryNumber[j]]];
    }
    
    return [result integerValue];
}

#pragma mark - Fast exponentiation

+ (NSInteger)fastExpForNumber:(NSInteger)number withPower:(NSInteger)power
{
    NSInteger result = 1;
    
    while (power) {
        if (power % 2 == 1) {
            result *= number;
        }
        power /= 2;
        number *= number;
    }
    
    return result;
}

#pragma mark - Number reverse

- (NSUInteger)reverseNumber
{
    NSUInteger numberToReverse = [self unsignedIntegerValue];
    NSUInteger rightDigit      = 0;
    NSMutableString *fooString = [@"" mutableCopy];
    
    do {
        rightDigit = numberToReverse % 10;
        [fooString appendString:[NSString stringWithFormat:@"%li", (long)rightDigit]];
        numberToReverse = numberToReverse / 10;
    }
    while (numberToReverse != 0);
    
    return (NSUInteger)[fooString integerValue];
}

#pragma mark - Even/Odd check

- (BOOL)isEven
{
    /*
     NSUInteger remainder = 0;
     remainder = [self intValue] % 2;
     
     return (remainder == 0) ? YES : NO;
     */
    
        // Machine way of doing odd/even check is better than mathematical check above
    BOOL evennessFlag = (self.intValue & 1) == NO;
    
    return evennessFlag;
}

#pragma mark - Leap year check

- (BOOL)isLeapGivenYear
{
    NSInteger givenYear = [self intValue];
    NSAssert(givenYear > 0 && givenYear <= 9999, @"Plz enter another year from 0001 - 10000 range");
    
    NSUInteger remainder_4 = 0, remainder_100 = 0, remainder_400 = 0;
    remainder_4   = givenYear % 4;
    remainder_100 = givenYear % 100;
    remainder_400 = givenYear % 400;
    
    return ((remainder_4 == 0 && remainder_100 != 0) || remainder_400 == 0) ? YES : NO;
}

#pragma mark - Armstrong number check

- (BOOL)isArmstrongNumber
{
    NSUInteger givenNumber = [self unsignedIntegerValue];
    NSUInteger s = 0, m = givenNumber, r = 0;
    
    do {
        r           = givenNumber % 10;
        givenNumber = givenNumber / 10;
        s           = s + r * r * r;
    }
    while (givenNumber != 0);
    
    return (s == m) ? YES : NO;
}

#pragma mark - Prime Number Check

- (BOOL)isPrime
{
    NSUInteger givenNumber = [self unsignedIntegerValue];
    
    if (givenNumber == 1 || givenNumber == 0) {
        return NO;
    }
    
    for (int i = 2; i <= (int)sqrt(givenNumber); i++) {
        if (givenNumber % i == 0) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Nth prime number

+ (NSUInteger)nthPrime:(NSUInteger)n
{
    NSUInteger number = 1, count = 0, i = 0;
    
    while (count < n) {
        number = number + 1;
        for (i = 2; i <= number; i++) {
            if (number % i == 0) {
                break;
            }
        }
        if (i == number) {
            count = count + 1;
        }
    }
    
    return number;
}

#pragma mark - Smart swap

+ (void)swapValueOfIntPointer:(NSInteger *)xPointer withValueOfIntPointer:(NSInteger *)yPointer
{
    *xPointer += *yPointer;
    *yPointer = *xPointer - *yPointer;
    *xPointer = *xPointer - *yPointer;
}

#pragma mark - Square root using Newton–Raphson algo

- (CGFloat)squareRoot
{
    if ([self floatValue] < 0) {
        return -1;
    }
    
    const CGFloat epsilon = 0.00001f;
    CGFloat guess = 1.0f;
    
    while ([NSNumber absoluteValue:guess * guess - [self floatValue]] >= epsilon) {
        guess = ([self floatValue] / guess + guess) / 2.0f;
    }
    
    return guess;
}

+ (CGFloat)absoluteValue:(CGFloat)number
{
    if (number < 0) {
        number = -number;
    }
    
    return number;
}

#pragma mark - Convert integer to another numeral system (2, 8, 12, 16)

- (id)convertedNumberWithBase:(int)base
{
    if (base != 2 && base != 8 && base != 10 && base != 12 && base != 16) {
        NSLog(@"Bad base - base must be 2, 8, 10, 12 or 16 only");
        base = 10;
    }
    
    const char baseDigits[16] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    long int numberToConvert = [self longValue];
    int convertedNumber[64];
    int nextDigit = 0, index = 0;
    id resultOfConvertion = nil;
    NSMutableString *resultString = [@"" mutableCopy];
    
    
    do {
        convertedNumber[index] = numberToConvert % base;
        ++index;
        numberToConvert = numberToConvert / base;
    }
    while (numberToConvert != 0);
    
    for (--index; index >= 0; --index) {
        nextDigit = convertedNumber[index];
        [resultString appendString:[NSString stringWithFormat:@"%c", baseDigits[nextDigit]]];
    }
    
    if (base == 2 || base == 8 || base == 10) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        NSNumber *myNumber   = [f numberFromString:resultString];
        resultOfConvertion   = myNumber;
    }
    else {
        resultOfConvertion = [resultString copy];
    }
    
    return resultOfConvertion;
}

#pragma mark - Fast inverse square root

- (CGFloat)fastInverseSquareRoot
{
    NSParameterAssert([self floatValue] > 0);
    
    Float32 result       = (Float32)[self floatValue];
    Float32 halfOfResult = result * 0.5f;
    
    int32_t i = *(int32_t *)&result;    // get bits for floating value
    i         = 0x5f3759df - (i >> 1);  // gives initial guess
    result    = *(Float32 *)&i;         // convert bits back to float
    
    for (NSUInteger idx = 0; idx < 4; idx++) {
        result = result * (1.5f - halfOfResult * result * result);  // Newton step, repeating increases accuracy
    }
    
    return result;
}

#pragma mark - Number Type

- (CFNumberType)numberType
{
    return CFNumberGetType((CFNumberRef)self);
}

#pragma mark - Quick Sum

+ (NSNumber *)sumOfNumbers:(NSArray *)numbers
{
    // Be careful about number types, we will
    // return the same type as first object in array
    NSNumber *sum    = nil;
    NSUInteger count = numbers.count;
    
    switch ([[numbers firstObject] numberType]) {
        case kCFNumberSInt32Type:
            sum = @([[numbers firstObject] intValue]);
            for (NSUInteger i = 1; i < count; i++) {
                sum = @([sum intValue] + [numbers[i] intValue]);
            }
            break;
            
        case kCFNumberSInt64Type:
            sum = @([[numbers firstObject] integerValue]);
            for (NSUInteger i = 1; i < count; i++) {
                sum = @([sum integerValue] + [numbers[i] integerValue]);
            }
            break;
            
        case kCFNumberFloat32Type:
        case kCFNumberFloat64Type:
            sum = @([[numbers firstObject] floatValue]);
            for (NSUInteger i = 1; i < count; i++) {
                sum = @([sum floatValue] + [numbers[i] floatValue]);
            }
            break;
            
        default:
            NSAssert(0, @"Not recognized type, check CFNumberType!");
            break;
    }
    
    return sum;
}

@end
