//
//  RadixNode.h
//  Radix Sort
//
//  Created by Stevenson on 27/02/2014.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadixNode : NSObject

@property (nonatomic) int data;
@property (nonatomic) RadixNode *next;

@end
