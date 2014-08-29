//
// Created by ASPCartman on 26/08/14.
//

#if TARGET_OS_IPHONE

#import "NSNumber+EKComparisonForIOS.h"


@implementation NSNumber (EKComparisonForIOS);

- (BOOL)isGreaterThan:(NSNumber *)obj
{
    NSParameterAssert([obj isKindOfClass:[NSNumber class]]);
    return [self compare:obj] == NSOrderedDescending;
}

- (BOOL)isLessThan:(NSNumber *)obj
{
    NSParameterAssert([obj isKindOfClass:[NSNumber class]]);
    return [self compare:obj] == NSOrderedAscending;
}

@end

#endif