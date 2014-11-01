//
//  NSDictionary+EKStuff.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 4/11/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "NSDictionary+EKStuff.h"
#import "NSNumber+EKStuff.h"


@implementation NSDictionary (EKStuff)

@end


@implementation NSMutableDictionary (EKStuff)

- (void)increaseValueForKey:(NSString *)key By:(NSNumber *)num
{
    id object = [self valueForKey:key];
    
    if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *value  = object;
        NSNumber *result = nil;
        
        switch ([value numberType]) {
            case kCFNumberSInt32Type:
                result = @([num intValue] + [value intValue]);
                break;
                
            case kCFNumberSInt64Type:
                result = @([num integerValue] + [value integerValue]);
                break;
                
            case kCFNumberFloat32Type:
            case kCFNumberFloat64Type:
                result = @([num floatValue] + [value floatValue]);
                break;
                
            default:
                NSAssert(0, @"Not recognized type, check CFNumberType!");
                result = value;
                break;
        }
        [self setValue:result forKey:key];
    }
    else {
        NSAssert(0, @"Object is not a instance of NSNumber!");
    }
}

- (void)increaseObjectForKey:(id)aKey By:(NSNumber *)num
{
    id object = self[aKey];
    
    if ([object isMemberOfClass:[NSNumber class]]) {
        NSNumber *value  = object;
        NSNumber *result = nil;
        
        switch ([value numberType]) {
            case kCFNumberSInt32Type:
                result = @([num intValue] + [value intValue]);
                break;
                
            case kCFNumberSInt64Type:
                result = @([num integerValue] + [value integerValue]);
                break;
                
            case kCFNumberFloat32Type:
            case kCFNumberFloat64Type:
                result = @([num floatValue] + [value floatValue]);
                break;
                
            default:
                NSAssert(0, @"Not recognized type, check CFNumberType!");
                result = value;
                break;
        }
        self[aKey] = result;
    }
    else {
        NSAssert(0, @"Object is not a instance of NSNumber!");
    }
}

- (void)selfIncreaseValueForKey:(NSString *)key
{
    [self increaseValueForKey:key By:@1];
}

- (void)selfDecreaseValueForKey:(NSString *)key
{
    [self increaseValueForKey:key By:@-1];
}

- (void)selfIncreaseObjectForKey:(NSString *)key
{
    [self increaseObjectForKey:key By:@1];
}

- (void)selfDecreaseObjectForKey:(NSString *)key
{
    [self increaseObjectForKey:key By:@-1];
}

@end
