//
//  EKString.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 21.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKStringStuff : NSObject

+ (BOOL)isGivenStringPalindrome:(NSString *)string;
+ (NSString *)reversedStringWithString:(NSString *)stringToReverse;
+ (NSUInteger)numberOfWordsInString:(NSString *)string;
+ (void)allPermutationsOfCString:(char *)string withFirstCharacterPosition:(int)i lastCharacterPosition:(int)n;
+ (void)countEachCharacterOccurenceInString:(NSString *)givenString;
+ (NSUInteger)numberOfNeedles:(NSString *)needle inHaystack:(NSString *)haystack;
+ (NSString *)randomStringWithLength:(NSUInteger)lenght;
+ (NSString *)concatenatedStringWithString:(NSString *)givenString secondString:(NSString *)secondString;
@end
