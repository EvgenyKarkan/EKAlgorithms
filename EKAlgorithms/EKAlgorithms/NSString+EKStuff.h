//
//  NSString+EKStuff.h
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EKStuff)

- (BOOL)isPalindrome;
- (NSString *)reversedString;
- (NSUInteger)numberOfWordsInString;
- (void)allPermutationsWithFirstCharacterPosition:(int)i lastCharacterPosition:(int)n;
- (void)countEachCharacterOccurrenceInString;
- (NSUInteger)numberOfOccurrenciesOfString:(NSString *)needle;
+ (NSString *)randomStringWithLength:(NSUInteger)lenght;
- (NSString *)concatenateWithString:(NSString *)secondString;
- (NSInteger)indexOfFirstOccurrenceOfNeedle:(NSString *)needle;
- (NSInteger)indexOfLastOccurrenceOfNeedle:(NSString *)needle;
+ (void)allPermutationsOfCString:(char *)string withFirstCharacterPosition:(int)i lastCharacterPosition:(int)n;

@end
