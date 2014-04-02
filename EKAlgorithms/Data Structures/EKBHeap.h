//
//  EKBHeap.h
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/30/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//


@interface EKBHeap : NSObject

- (void)insertNumber:(NSNumber *)num;
- (NSNumber *)deleteMin;
- (BOOL)isEmpty;

@end
