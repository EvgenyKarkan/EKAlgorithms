//
//  EKRecursionStuff.h
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 26.01.14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


@interface EKRecursionStuff : NSObject

+ (void)solveTowerOfHanoiWithDisksNumber:(NSUInteger)number
                                    from:(id)fromPin
                                      to:(id)toPin
                            withExtraPin:(id)extraPin;

@end
