//
//  EKRecursionStuff.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 26.01.14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#import "EKRecursionStuff.h"


@implementation EKRecursionStuff;

+ (void)solveTowerOfHanoiWithDisksNumber:(NSUInteger)number
                                    from:(id)fromPin
                                      to:(id)toPin
                            withExtraPin:(id)extraPin
{
    NSParameterAssert(number > 0);
    NSParameterAssert(fromPin != nil);
    NSParameterAssert(toPin != nil);
    NSParameterAssert(extraPin != nil);
    
    if (number == 1) {
        NSLog(@"Move disk 1 from pin %@ to Pin %@", fromPin, toPin);
        return;
            //Minimal moves count should be equal to 2^number - 1
            //e.g 3 disks --> 2^3 - 1 = 7 moves
    }
    
    [self solveTowerOfHanoiWithDisksNumber:number - 1 from:fromPin to:extraPin withExtraPin:toPin];
    
    NSLog(@"Move disk %lu from pin %@ to pin %@", (unsigned long)number, fromPin, toPin);
    
    [self solveTowerOfHanoiWithDisksNumber:number - 1 from:extraPin to:toPin withExtraPin:fromPin];
}

@end
