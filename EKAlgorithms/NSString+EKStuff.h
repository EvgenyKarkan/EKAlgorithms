//
//  NSString+EKStuff.h
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface NSString (EKStuff)

- (BOOL)isPalindrome;
- (NSString *)reversedString;
- (NSUInteger)numberOfWordsInString;
- (void)countEachCharacterOccurrenceInString;
- (NSUInteger)numberOfOccurrenciesOfString:(NSString *)needle;
+ (NSString *)randomStringWithLength:(NSUInteger)lenght;
- (NSString *)concatenateWithString:(NSString *)secondString;
- (NSInteger)indexOfFirstOccurrenceOfNeedle:(NSString *)needle;
- (NSInteger)indexOfLastOccurrenceOfNeedle:(NSString *)needle;
+ (void)allPermutationsOfCString:(char *)string withFirstCharacterPosition:(int)i lastCharacterPosition:(int)n;

/**
 *@param
 *  other: the string for comparing with self
 *@Output
 *  an array of common sequence of the two strings
 */
- (NSArray*)LCS_WithString:(NSString*)other;
/**
 *@param
 *  other: the string for comparing with self
 *@Output
 *  the Levenshtein Distance of the two strings
 */
- (NSInteger)LD_WithString:(NSString*)other;

- (NSInteger)KMPindexOfSubstringWithPattern:(NSString *)pattern;

@end
