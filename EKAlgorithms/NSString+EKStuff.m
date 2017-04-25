//
//  NSString+EKStuff.m
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "NSString+EKStuff.h"
#import <objc/runtime.h>


@implementation NSString (EKStuff);

#pragma mark - Is string palindrome

- (BOOL)isPalindrome
{
    BOOL result = NO;
    NSString *nonWhitespacedBufferString = [[self stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
    NSString *reverseString              = [self reversedString];
    
    result = [reverseString isEqualToString:nonWhitespacedBufferString] ? YES : NO;
    
    return result;
}

#pragma mark - String reverse

- (NSString *)reversedString
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (NSInteger i = (NSInteger)[self length] - 1; i >= 0; i--) {
        [result appendString:[NSString stringWithFormat:@"%C", [self characterAtIndex: (NSUInteger)i]]];
    }
    
    return [result copy];
}

#pragma mark - Words in string count

- (NSUInteger)numberOfWordsInString
{
    const char *str        = [self UTF8String];
    BOOL state             = NO;
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
    temp      = *xPointer;
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

    NSUInteger length = [self length];

    for (NSInteger i = 0; i < length; i++) {
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
    NSString *reversedNeedle   = [needle reversedString];
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

#pragma mark - Longest common sequence

static char arrayKey;

enum decreaseDir {kInit = 0, kLeftUp, kUp, kLeft};

- (NSArray *)LCS_WithString:(NSString *)other
{
    if (other == nil) {
        return 0;
    }
    
    size_t m = self.length;
    size_t n = other.length;
    
    if (m == 0 || n == 0) {
        return 0;
    }
    
    NSMutableArray *c = [NSMutableArray arrayWithCapacity:m + 1];
    NSMutableArray *b = [NSMutableArray arrayWithCapacity:m + 1];
    
    for (int i = 0; i <= m; i++) {
        c[i] = [NSMutableArray arrayWithCapacity:n + 1];
        b[i] = [NSMutableArray arrayWithCapacity:n + 1];
        
        for (int j = 0; j <= n; j++) {
            c[i][j] = @(0);
            b[i][j] = @(kInit);
        }
    }
    
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if ([[self substringWithRange:NSMakeRange(i, 1)] isEqual:[other substringWithRange:NSMakeRange(j, 1)]]) {
                c[i + 1][j + 1] = @([c[i][j] integerValue] + 1);
                b[i + 1][j + 1] = @(kLeftUp); //↖
            }
            else if ([c[i][j + 1] integerValue] >= [c[i + 1][j] integerValue]) {
                c[i + 1][j + 1] = @([c[i][j + 1] integerValue]);
                b[i + 1][j + 1] = @(kUp);  //↑
            }
            else {
                c[i + 1][j + 1] = @([c[i + 1][j] integerValue]);
                b[i + 1][j + 1] = @(kLeft); //←
            }
        }
    }
    
    NSMutableArray *charArray = objc_getAssociatedObject(self, &arrayKey);
    if (charArray) {
        charArray = nil;
    }
    charArray = [NSMutableArray array];
    objc_setAssociatedObject(self, &arrayKey, charArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self LCS_Print:b withString:other row:m andColumn:n];
    
    return charArray;
}

/** Print a LCS of two strings
 * @param LCS_direction: a 2-dimension matrix which records the direction of LCS generation
 *                other: the second string
 *                  row: the row index in the matrix LCS_direction
 *                  col: the column index in the matrix LCS_direction
 **/
- (void)LCS_Print:(NSArray *)direction
       withString:(NSString *)other
              row:(NSInteger)i
        andColumn:(NSInteger)j
{
    if (other == nil) {
        return;
    }
    
    size_t length1 = self.length;
    size_t length2 = other.length;
    
    if (length1 == 0 || length2 == 0 || i == 0 || j == 0) {
        return;
    }
    
    if ([direction[i][j] integerValue] == kLeftUp) {
        NSLog(@"%@ %@ ", self, [self substringWithRange:NSMakeRange(i - 1, 1)]);     //reverse
        
        NSMutableArray *charArray = objc_getAssociatedObject(self, &arrayKey);
        [charArray insertObject:[self substringWithRange:NSMakeRange(i - 1, 1)] atIndex:0];
        
        [self LCS_Print:direction withString:other row:i - 1 andColumn:j - 1];
    }
    else if ([direction[i][j] integerValue] == kUp) {
        [self LCS_Print:direction withString:other row:i - 1 andColumn:j];
    }
    else {
        [self LCS_Print:direction
             withString:other
                    row:i
              andColumn:j - 1];
    }
}

#pragma mark -  Levenshtein distance

- (NSInteger)LD_WithString:(NSString *)other
{
        //creating and retaining a matrix of size self.length+1 by other.length+1
    
    if (other == nil) {
        return self.length;
    }
    
    size_t m = self.length;
    size_t n = other.length;
    
    if (m == 0 || n == 0) {
        return abs((int)m - (int)n);
    }
    
    NSMutableArray *d = [NSMutableArray arrayWithCapacity:m + 1];
    
    for (int i = 0; i <= m; i++) {
        d[i] = [NSMutableArray arrayWithCapacity:n + 1];
        d[i][0] = @(i);
    }
    
    for (int j = 0; j <= n; j++) {
        d[0][j] = @(j);
    }
    
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            int cost = ![[self substringWithRange:NSMakeRange(i - 1, 1)] isEqual:[other substringWithRange:NSMakeRange(j - 1, 1)]];
            
            int min1 = [d[i - 1][j] intValue] + 1;
            int min2 = [d[i][j - 1] intValue] + 1;
            int min3 = [d[i - 1][j - 1] intValue] + cost;
            
            d[i][j] = @(MIN(MIN(min1, min2), min3));
        }
    }
    
    return [d[m][n] integerValue];
}

#pragma mark - KMP (Knuth-Morris-Prat)

- (NSInteger)KMPindexOfSubstringWithPattern:(NSString *)pattern
{
    NSParameterAssert(pattern != nil);
    
    NSUInteger selfLenght    = [self length];
    NSUInteger patternLenght = [pattern length];
    
    NSInteger *prefix = [self computePrefixFunctionForPattern:pattern];
    NSParameterAssert(prefix != NULL);
    
    const char *utf8Self        = [self UTF8String];
    size_t self_C_string_lenght = strlen(utf8Self) + 1;
    
    char haystack_C_array[self_C_string_lenght];
    memcpy(haystack_C_array, utf8Self, self_C_string_lenght);
    
    const char *utf8Pattern        = [pattern UTF8String];
    size_t pattern_C_string_lenght = strlen(utf8Pattern) + 1;
    
    char needle_C_array[pattern_C_string_lenght];
    memcpy(needle_C_array, utf8Pattern, pattern_C_string_lenght);
    
    NSInteger k = -1;
    
    for (NSUInteger i = 0; i < selfLenght; i++) {
        while (k > -1 && needle_C_array[k + 1] != haystack_C_array[i]) {
            k = prefix[k];
        }
        if (haystack_C_array[i] == needle_C_array[k + 1]) {
            k++;
        }
        if (k == patternLenght - 1) {
            free(prefix);
            return i - k;
        }
    }
    free(prefix);
    
    return -1;
}

- (NSInteger *)computePrefixFunctionForPattern:(NSString *)pattern
{
    NSUInteger pattern_ObjC_string_lenght = [pattern length];
    
    const char *utf8Pattern        = [pattern UTF8String];
    size_t pattern_C_string_lenght = strlen(utf8Pattern) + 1;
    
    char pattern_C_Array[pattern_C_string_lenght];
    memcpy(pattern_C_Array, utf8Pattern, pattern_C_string_lenght);
    
    NSInteger *prefix = malloc(sizeof(NSInteger) * pattern_ObjC_string_lenght);
    NSParameterAssert(prefix != NULL);
    
    NSInteger k = -1;
    prefix[0] = k;
    
    for (NSUInteger i = 1; i < pattern_ObjC_string_lenght; i++) {
        while (k > -1 && pattern_C_Array[k + 1] != pattern_C_Array[i]) {
            k = prefix[k];
        }
        if (pattern_C_Array[i] == pattern_C_Array[k + 1]) {
            k++;
        }
        prefix[i] = k;
    }
    return prefix;
}

#pragma mark - Boyer Moore

#define ALPHABET_LEN 256

/**
    https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_string_search_algorithm
    In computer science, the Boyer–Moore string search algorithm is an efficient string searching algorithm that is the standard benchmark for practical string search literature.
    Chances are very good that at some point you have done a search in a web document or file on your hard drive, and that search was implemented using Boyer-Moore.
    Of note, in general, the algorithm runs faster as the pattern length increases.
*/

- (NSRange)BMindexOfSubstringWithPattern:(NSString *)pattern index:(NSUInteger)index {
    const char *utf8Pattern = pattern.UTF8String;
    const char *utf8String = [self substringFromIndex:index].UTF8String;

    size_t length = strlen(utf8Pattern);
    size_t stringLength = strlen(utf8String);

    char pat[length];
    char string[stringLength];

    memcopy(pat, utf8Pattern, length);
    memcopy(string, utf8String, stringLength);

    pat[length] = '\0';
    string[stringLength] = '\0';

    size_t patternMap1[ALPHABET_LEN];
    size_t *patternMap2 = malloc(length * sizeof(size_t));

    patMap(patternMap1, pat, &length);
    prefixSuffixMap(patternMap2, pat, &length);

    size_t i = length - 1;

    while (i < stringLength) {
        signed long j = length - 1;

        while (j >= 0 && string[i] == pat[j]) {
            --i;
            --j;
        }

        if (j < 0) {
            free(patternMap2);
            return NSMakeRange(i+1, length);
        }

        i += MAX(patternMap1[string[i]], patternMap2[j]);
    }

    free(patternMap2);
    return NSMakeRange(NSNotFound, NSNotFound);
}

//For bad character rule
//The distance each char is from the end. (patternLength - index of char).
void patMap(size_t *map, char *pattern, size_t *patternLength) {
    size_t i;
    uint8_t alphabetSize = ~(char)0; //Flip the bits on a 8 bit int value 0 and you get 255.

    for (i = 0; i < alphabetSize; i++) {
        map[i] = *patternLength;
    }

    for (i = 0; i < *patternLength;i++) {
        map[pattern[i]] = *patternLength - 1 - i; //The ascii char value is the key.
    }
}

bool isPrefix (char *pattern, size_t *patternLength, int position) {
    int i;
    int suffixLength = (int)*patternLength - position;

    for (i = 0; i < suffixLength; i++) {
        if (pattern[i] != pattern[position+i]) {
            return false;
        }
    }

    return true;
}

int suffixLength (char *pattern, size_t *patternLength, int position) {
    int suffixLength = 0;

    //TODO: Make this more readable.
    bool (^notMismatched)(int) = ^bool(int loc){
        return (pattern[position - loc] == pattern[*patternLength - 1 - loc]) && loc < position;
    };

    while (notMismatched(suffixLength)) {
        suffixLength++;
    }

    return suffixLength;
}

//For the good character rules
void prefixSuffixMap(size_t *map2, char *pattern, size_t *patternLength) {
    int i = 0;

    int lastPrefixIndex = 1;

    for (i = (int)*patternLength - 1; i >= 0; i--) {
        if (isPrefix(pattern, patternLength, i+1)) {
            lastPrefixIndex = i+1;
        }
        map2[i] = (*patternLength - 1 - i) + lastPrefixIndex;
    }

    for (i = 0; i < *patternLength; i++) {
        int suffLength = suffixLength(pattern, patternLength, i);

        if (pattern[i - suffLength] != pattern [*patternLength - 1 - suffLength]) {
            map2[*patternLength - 1 - suffLength] = *patternLength - 1 - i + suffLength;
        }
    }
}

//Boundary aligned memcopy for 64 bit.
void memcopy(void *dest, const void *src, size_t size) {
#define NBITS 64

    char *d = (char *)dest;
    char *s = (char *)src;
    int n = 0;

    while ((((uintptr_t) d & (NBITS - 1)) != 0x0) && n < size) {
        *d++ = *s++;
        n++;
    }

    long * dest2 = (long *)d;
    long * src2 = (long *)s;

    //Copy 64 bit words at a time. 8 * faster.
    uint64 max = size > sizeof(long) ? size - sizeof(long) : 0;
    while (n < max) {
        *dest2++ = *src2++;
        n += sizeof(long);
    }

    s = (char *)src2;
    d = (char *)dest2;
    while (n < size) {
        *d++ = *s++;
        n++;
    }
}

@end
