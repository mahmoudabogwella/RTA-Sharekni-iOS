//
//  NSObject+Blocks.h
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (Blocks)
- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay;
@end
