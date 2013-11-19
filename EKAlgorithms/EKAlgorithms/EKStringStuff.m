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

+ (void)countEachCharacterOccurenceInString:(NSString *)givenString
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

@end

