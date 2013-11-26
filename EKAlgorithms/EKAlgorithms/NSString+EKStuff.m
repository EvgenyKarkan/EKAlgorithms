//
//  NSString+EKStuff.m
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSString+EKStuff.h"

@implementation NSString (EKStuff)

#pragma mark - Is string palindrome

- (BOOL)isPalindrome
{
	BOOL result = NO;
	NSString *nonWhitespacedBufferString = [[self stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
	NSString *reverseString = [self reversedString];
	
    result = [reverseString isEqualToString:nonWhitespacedBufferString] ? YES : NO;
    
	return result;
}

#pragma mark - String reverse

- (NSString *)reversedString
{
	NSMutableString *result = [[NSMutableString alloc] init];
    
	for (NSInteger i = [self length] - 1; i >= 0; i--) {
		[result appendString:[NSString stringWithFormat:@"%C", [self characterAtIndex:i]]];
	}
    
	return [result copy];
}

#pragma mark - Words in string count

- (NSUInteger)numberOfWordsInString
{
	const char *str = [self UTF8String];
	BOOL state = NO;
	NSUInteger wordCounter = 0;
    
	while (*str) {
		if (*str == ' ' || *str == '\n' || *str == '\t') {
			state = NO;
		}
		else if (state == NO) {
			state = YES;
			++wordCounter;
		}
        
		++str;
	}
    
	return wordCounter;
}

#pragma mark - Permutations of string

+ (void)swapValuesOfPointer:(char *)xPointer toPointer:(char *)yPointer
{
	char temp;
	temp = *xPointer;
	*xPointer = *yPointer;
	*yPointer = temp;
}

+ (void)allPermutationsOfCString:(char *)string withFirstCharacterPosition:(int)i lastCharacterPosition:(int)n
{
	if (i == n) {
		NSLog(@"Permutation is - %s\n", string);
	}
	else {
		for (NSUInteger j = i; j <= n; j++) {
			[self swapValuesOfPointer:(string + i) toPointer:(string + j)];
			[self allPermutationsOfCString:string withFirstCharacterPosition:i + 1 lastCharacterPosition:n];
			[self swapValuesOfPointer:(string + i) toPointer:(string + j)];
		}
	}
}

#pragma mark - Occurrences of each character

- (void)countEachCharacterOccurrenceInString
{
	const char *string = [[self lowercaseString] UTF8String];
	int c = 0, count[26] = { 0 };
    
	while (string[c] != '\0') {
		if (string[c] >= 'a' && string[c] <= 'z') {
			count[string[c] - 'a']++;
		}
		c++;
	}
    
	for (c = 0; c < 26; c++) {
		if (count[c] != 0) {
			NSLog(@"%c occurs %d times in the entered string\n", c + 'a', count[c]);
		}
	}
	//TODO: modify to handle uppercase and special characters
}

#pragma mark - Count needles in a haystack

- (NSUInteger)numberOfOccurrenciesOfString:(NSString *)needle
{
	NSUInteger count = 0, length = [self length];
	NSRange range = NSMakeRange(0, length);
    
	while (range.location != NSNotFound) {
		range = [self rangeOfString:needle options:0 range:range];
		if (range.location != NSNotFound) {
			range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
			count++;
		}
	}
    
	return count;
}

#pragma mark - Random string

+ (NSString *)randomStringWithLength:(NSUInteger)lenght
{
	static char const possibleChars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 !@#$%^&*()_-/?;:+=[]|~<>";
	unichar characters[lenght];
    
	for (NSUInteger index = 0; index < lenght; ++index) {
		characters[index] = possibleChars[arc4random_uniform(sizeof(possibleChars) - 1)];
	}
    
	return [NSString stringWithCharacters:characters length:lenght];
}

#pragma mark - Concatenation

- (NSString *)concatenateWithString:(NSString *)secondString
{
	const char *cStringOne = [self UTF8String];
	const char *cStringTwo = [secondString UTF8String];
	char cResult[256];
    
	NSUInteger i = 0, j = 0;
    
	for (i = 0; cStringOne[i] != '\0'; ++i) {
		cResult[i] = cStringOne[i];
	}
	for (j = 0; cStringTwo[j] != '\0'; ++j) {
		cResult[i + j] = cStringTwo[j];
	}
	cResult[i + j] = '\0';
    
	NSString *objcString = [NSString stringWithFormat:@"%s", cResult];
    
	return objcString;
}

#pragma mark - First occurrence of needle in a haystack

- (NSInteger)indexOfFirstOccurrenceOfNeedle:(NSString *)needle
{
	NSAssert(needle != nil || self != nil, @"Seems you are trying to pass nil as a parameter");
	NSAssert(![needle isEqualToString:@""], @"Needle should be valid");
	NSAssert(![self isEqualToString:@""], @"Haystack should be valid");
	NSAssert([needle length] <= [self length], @"Needle should be less or equal in compare with haystack");
    
	NSInteger indexOfFirstOccurrence = -1;
	NSInteger j = 0;
    
	for (NSInteger i = 0; i < [self length]; i++) {
		if ([self characterAtIndex:i] == [needle characterAtIndex:j]) {
			if (j == 0) {
				indexOfFirstOccurrence = i;
			}
			if (j == [needle length] - 1) {
				return indexOfFirstOccurrence;
			}
			j++;
		}
		else if ([self characterAtIndex:i] != [needle characterAtIndex:j] && j > 0) {
			i--;
			j = 0;
			indexOfFirstOccurrence = -1;
		}
	}
    
	return indexOfFirstOccurrence;
}

#pragma mark - Last occurrence of needle in a haystack

- (NSInteger)indexOfLastOccurrenceOfNeedle:(NSString *)needle
{
	NSString *reversedNeedle = [needle reversedString];
	NSString *reversedHaystack = [self reversedString];
    
	NSInteger firstOccurrenceInReversedString = [reversedHaystack indexOfFirstOccurrenceOfNeedle:reversedNeedle];
    
	NSInteger result = 0;
    
	if (firstOccurrenceInReversedString >= 0) {
		result = [self length] - [needle length] - firstOccurrenceInReversedString;
	}
	else {
		result = -1;
	}
    
	return result;
}

@end
