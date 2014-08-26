//
// Created by ASPCartman on 26/08/14.
//

#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>

@interface NSObject (EKComparisonForIOS)
- (BOOL) isEqualTo:(id)obj;
@end

#endif