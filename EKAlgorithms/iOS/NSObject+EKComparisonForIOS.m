//
// Created by ASPCartman on 26/08/14.
//

#if TARGET_OS_IPHONE

#import "NSObject+EKComparisonForIOS.h"


@implementation NSObject (EKComparisonForIOS);

- (BOOL)isEqualTo:(id)other
{
    return [self isEqual:other];
}

@end

#endif