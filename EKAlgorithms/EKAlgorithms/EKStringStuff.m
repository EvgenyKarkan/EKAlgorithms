//
//  EKString.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 21.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKStringStuff.h"

@implementation EKStringStuff;

#pragma mark - Is string palindrome

+ (BOOL)isGivenStringPalindrome:(NSString *)string
{
	BOOL result = NO;
	NSString *nonWhitespacedBufferString = [[string stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
	NSMutableString *reverseString = [[NSMutableString alloc] initWithCapacity:[nonWhitespacedBufferString length]];
	
	for (NSInteger i = [nonWhitespacedBufferString length] - 1; i >= 0; i--) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-security"
		[reverseString appendFormat:[NSString stringWithFormat:@"%c", [nonWhitespacedBufferString characterAtIndex:i]]];
#pragma clang diagnostic pop
	}
	   
    result = [reverseString isEqualToString:nonWhitespacedBufferString] ? YES : NO;
    
	return result;
}

#pragma mark - String reverse

+ (NSString *)reversedStringWithString:(NSString *)stringToReverse
{
	NSMutableString *result = [[NSMutableString alloc] init];
    
	for (NSUInteger i = [stringToReverse length] - 1; i < [stringToReverse length]; i--) {
		[result appendString:[NSString stringWithFormat:@"%C", [stringToReverse characterAtIndex:i]]];
	}
    
	return [result copy];
}

#pragma mark - Words in string count

+ (NSUInteger)numberOfWordsInString:(NSString *)string
{
	const char *str = [string UTF8String];
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

+ (void)countEachCharacterOccurrenceInString:(NSString *)givenString
{
	const char *string = [[givenString lowercaseString] UTF8String];
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

+ (NSUInteger)numberOfNeedles:(NSString *)needle inHaystack:(NSString *)haystack
{
	NSUInteger count = 0, length = [haystack length];
	NSRange range = NSMakeRange(0, length);
    
	while (range.location != NSNotFound) {
		range = [haystack rangeOfString:needle options:0 range:range];
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

+ (NSString *)concatenatedStringWithString:(NSString *)givenString secondString:(NSString *)secondString
{
	const char *cStringOne = [givenString UTF8String];
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

+ (NSInteger)indexOfFirstOccurrenceOfNeedle:(NSString *)needle inHaystack:(NSString *)haystack
{
	NSAssert(needle != nil || haystack != nil, @"Seems you are trying to pass nil as a parameter");
	NSAssert(![needle isEqualToString:@""], @"Needle should be valid");
	NSAssert(![haystack isEqualToString:@""], @"Haystack should be valid");
	NSAssert([needle length] <= [haystack length], @"Needle should be less or equal in compare with haystack");
    
	NSInteger indexOfFirstOccurrence = -1;
	NSInteger j = 0;
    
	for (NSInteger i = 0; i < [haystack length]; i++) {
		if ([haystack characterAtIndex:i] == [needle characterAtIndex:j]) {
			if (j == 0) {
				indexOfFirstOccurrence = i;
			}
			if (j == [needle length] - 1) {
				return indexOfFirstOccurrence;
			}
			j++;
		}
		else if ([haystack characterAtIndex:i] != [needle characterAtIndex:j] && j > 0) {
			i--;
			j = 0;
			indexOfFirstOccurrence = -1;
		}
	}
    
	return indexOfFirstOccurrence;
}

@end

