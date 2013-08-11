//
//  EKSearch.m
//  EKAlgorithms
//
//  Created by Каркан Евгений on 11.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKSearch.h"

@implementation EKSearch

+ (NSInteger)linearSearchForObject:(id)object inArray:(NSArray *)arrayToSearch
{
	NSInteger i, indexOfFoundedObject = 0;
	
	for (i = 0; i < [arrayToSearch count]; i++) {
		if (object == [arrayToSearch objectAtIndex:i]) {
			indexOfFoundedObject = i;
			break;
		}
	}
	if (i == [arrayToSearch count]) {
		indexOfFoundedObject = -1;
	}
	
	return indexOfFoundedObject;
}

@end
