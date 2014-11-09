//
//  NSDictionary+EKStuff.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 4/11/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


@interface NSDictionary (EKStuff)

@end


@interface NSMutableDictionary (EKStuff)

- (void)increaseValueForKey:(NSString *)key By:(NSNumber *)num;
- (void)increaseObjectForKey:(id)aKey By:(NSNumber *)num;
- (void)selfIncreaseValueForKey:(NSString *)key;
- (void)selfDecreaseValueForKey:(NSString *)key;
- (void)selfIncreaseObjectForKey:(NSString *)key;
- (void)selfDecreaseObjectForKey:(NSString *)key;

@end
