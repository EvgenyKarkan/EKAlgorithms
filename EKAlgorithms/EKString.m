//
//  EKString.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 21.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKString.h"

@implementation EKString

+ (BOOL)isGivenStringPalindrom:(NSString *)string
{
	BOOL result = NO;
	
	NSMutableString *reverseString = [[NSMutableString alloc] initWithCapacity:[string length]];
	
	for (NSInteger i = [string length] - 1; i >= 0; i--) {
	#pragma clang diagnostic push
	#pragma clang diagnostic ignored "-Wformat-security"
		[reverseString appendFormat:[NSString stringWithFormat:@"%c", [string characterAtIndex:i]]];
	#pragma clang diagnostic pop
	}
	
	if ([reverseString isEqualToString:string]) {
		result = YES;
	}
	else {
		result = NO;
	}
	
	return result;
}

@end


