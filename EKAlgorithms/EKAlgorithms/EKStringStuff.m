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
	
	if ([reverseString isEqualToString:nonWhitespacedBufferString]) {
		result = YES;
	}
	else {
		result = NO;
	}
    
	return result;
}

#pragma mark - String reverse

+ (NSString *)reversedStringWithString:(NSString *)stringToReverse
{
	NSMutableString *result = [[NSMutableString alloc] init];
    
	for (NSUInteger i = [stringToReverse length] - 1; i < [stringToReverse length]; i--) {
		[result appendString:[NSString stringWithFormat:@"%C", [stringToReverse characterAtIndex:i]]];
	}
    
    NSLog(@"Class %@", [NSString superclass]);
    
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

/* Function to swap values at two pointers */
void swap (char *x, char *y)
{
    char temp;
    temp = *x;
    *x = *y;
    *y = temp;
}

/* Function to print permutations of string
 This function takes three parameters:
 1. String
 2. Starting index of the string
 3. Ending index of the string. */
void permute(char *a, int i, int n)
{
	int j;
	if (i == n) {
		printf("%s\n", a);
	}
	else {
		for (j = i; j <= n; j++) {
			swap((a + i), (a + j));
			permute(a, i + 1, n);
			swap((a + i), (a + j)); //backtrack
		}
	}
}

@end

