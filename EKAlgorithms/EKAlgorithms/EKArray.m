//
//  EKArray.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKArray.h"

@implementation EKArray

+ (NSUInteger)indexOfMaximumElementInArray:(NSArray *)array
{
	id max = [array objectAtIndex:0];
	
	for (int i = 1; i < [array count]; i++) {
		if ([array objectAtIndex:i] > max) {
			max = [array objectAtIndex:i];
		}
	}
	
	return [array indexOfObject:max];
}

@end


