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

+ (NSString *)reversedStringWithString:(NSString *)stringToReverse
{
	NSMutableString *result = [[NSMutableString alloc] init];
    
	for (NSUInteger i = [stringToReverse length] - 1; i < [stringToReverse length]; i--) {
		[result appendString:[NSString stringWithFormat:@"%C", [stringToReverse characterAtIndex:i]]];
	}
    
	return [result copy];
}

@end


